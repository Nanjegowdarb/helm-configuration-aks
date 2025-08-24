#!/bin/bash
set -e

NAMESPACE="demo-abb-${ENVIRONMENT}"

# Update Chart.yaml
echo "appVersion: 1.2.1" >> helm/app/Chart.yaml
cat helm/app/Chart.yaml

# Check if values file exists
VALUES_FILE="helm/stages/${REGION}.${ENVIRONMENT}/values.yaml"
if [ ! -f "$VALUES_FILE" ]; then
    echo "Error: Values file not found: $VALUES_FILE"
    echo "Available files:"
    find helm/stages -name "values.yaml" 2>/dev/null || echo "No values files found"
    exit 1
fi

echo "Using values file: $VALUES_FILE"

# Check if namespace exists in Kubernetes
kubectl get namespace "$NAMESPACE" > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "Namespace $NAMESPACE already exists. Skipping creation."
else
    echo "Namespace $NAMESPACE not found. Creating namespace..."
    kubectl create namespace "$NAMESPACE" || exit 1
    echo "Namespace $NAMESPACE created successfully."
fi

helm version

helm upgrade helmrelease helm/app \
  --wait \
  --install \
  --timeout "10m0s" \
  --namespace "$NAMESPACE" \
  --values "$VALUES_FILE" \
  --set image.repository="$REPOSITORY" \
  --set image.tag="$IMAGE_TAG" \
  || exit 4

echo "Deployment completed successfully!"

# Build stage
FROM node:16-alpine AS build-stage

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

# Production stage
FROM nginx:stable-alpine

# Use built-in nginx user and set proper permissions
RUN chown -R nginx:nginx /var/cache/nginx /var/run

# Copy build output
COPY --from=build-stage --chown=nginx:nginx /app/dist /usr/share/nginx/html

# No need to switch user - runs as nginx by default
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
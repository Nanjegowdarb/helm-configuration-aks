{{/* vim: set filetype=mustache: */}}

{{- define "labels" }}
app: {{ .Chart.Name }}
chart: {{ printf "%s-%s" .Chart.Name .Chart.Version }}
release: {{ .Release.Name }}
{{- end }}

{{- define "image" -}}
{{ .Values.image.repository }}:{{ .Values.image.tag }}
{{- end -}}

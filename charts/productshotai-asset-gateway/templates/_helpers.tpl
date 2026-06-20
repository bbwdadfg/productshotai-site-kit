{{- define "productshotai-asset-gateway.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "productshotai-asset-gateway.fullname" -}}
{{- if .Release.Name -}}
{{- printf "%s-%s" .Release.Name (include "productshotai-asset-gateway.name" .) | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- include "productshotai-asset-gateway.name" . -}}
{{- end -}}
{{- end -}}

{{- define "productshotai-asset-gateway.labels" -}}
app.kubernetes.io/name: {{ include "productshotai-asset-gateway.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
{{- end -}}

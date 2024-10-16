{{/*
Criar as tags
*/}}
{{- define "app.labels" -}}
app: {{ .labels.app | quote }}
env: {{ .labels.env | quote }}
{{- end }}

{{/*
Limit resources
*/}}
{{- define "app.chama-bloco" -}}
requests: 
  memory: {{ .resources.requests.memory }}
  cpu: {{ .resources.requests.cpu }}
limits: 
  memory: {{ .resources.limits.memory }}
  cpu: {{ .resources.limits.cpu }}
{{- end }}

{{/*
Definir portas
*/}}
{{- define "app.ports" -}}
{{- range .ports }}
- containerPort: {{ .port }}
{{- end }}
{{- end }}

{{/*
Definir ConfigMap
*/}}
{{- define "database.configmap" -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .component }}-database
data:
  app-config.yaml: |
    {{ toYaml .config | nindent 4 }}
{{- end }}

{{/*
Definir Observability
*/}}
{{- define "observability.configmap" }}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .component }}-configmap
data:
  app-config.json: |
    {{ toJson .config }}
{{- end }}
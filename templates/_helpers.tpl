{{/*
fullname 헬퍼: 릴리즈명-차트명 조합
*/}}
{{- define "k8s-security.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
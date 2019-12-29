{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the app.
*/}}
{{- define "app.name" -}}
{{- $name := default .Chart.Name .Values.app.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "app.fullName" -}}
{{- if .Values.app.fullNameOverride -}}
{{- .Values.app.fullNameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.app.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.meta.env | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.meta.env | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Expand the name of the debugger.
*/}}
{{- define "debugger.name" -}}
{{- $name := default "debugger" .Values.debugger.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified debugger name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "debugger.fullName" -}}
{{- if .Values.debugger.fullNameOverride -}}
{{- .Values.debugger.fullNameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default "debugger" .Values.debugger.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.meta.env | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.meta.env | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "meta.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Filter version to prenvent integer from being cast into float64.
https://github.com/helm/helm/issues/1707
*/}}
{{- define "meta.version" -}}
{{- $version :=  .Values.meta.version -}}
{{- $type := printf "%T" $version -}}
{{- if eq $type "float64" -}}
{{- printf "%.0f" $version | quote -}}
{{- else }}
{{- $version | quote -}}
{{- end -}}
{{- end }}

{{/*
Filter image tag to prenvent integer from being cast into float64.
https://github.com/helm/helm/issues/1707
*/}}
{{- define "image.tag" -}}
{{- $tag :=  .Values.image.tag -}}
{{- $type := printf "%T" $tag -}}
{{- if eq $type "float64" -}}
{{- printf "%.0f" $tag -}}
{{- else }}
{{- $tag -}}
{{- end -}}
{{- end }}

{{/*
Common labels
*/}}
{{- define "app.labels" -}}
app.kubernetes.io/name: {{ .Release.Name }}
helm.sh/chart: {{ include "meta.chart" . }}
app.kubernetes.io/instance: {{ .Values.meta.env }}
app.kubernetes.io/component: {{ .Chart.Name }}
app.kubernetes.io/version: {{ include "meta.version" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

SHELL          = /bin/bash
APP_NAME       = app
VERSION       := 0.0.1
ENVIRONMENT    = dev

.PHONY: default
default: help

.PHONY: help
help:
	@echo 'Management commands for ${APP_NAME}:'
	@echo
	@echo 'Usage:'
	@echo '    make terraform             Deploy infra via Terraform.'
	@echo '    make helm                  Deploy to Kubernetes via Helm.'

	@echo

.PHONY: terraform
terraform:
	@echo "Deploying infra"
	cd terraform && \
	terraform init && \
	terraform apply

.PHONY: helm
helm:
	@echo "Deploying ${APP_NAME} ${VERSION}"
	helm upgrade ${APP_NAME} kubernetes/app-chart --install \
		--namespace ${ENVIRONMENT} \
		--values kubernetes/helm-values/${ENVIRONMENT}.yaml \
		--set meta.env=${ENVIRONMENT},meta.version=${VERSION},image.repository=${REGISTRY_URL}/${APP_NAME},image.tag=${VERSION}

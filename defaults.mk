# Docker Variables
AWS_DEFAULT_REGION ?= us-east-1
ECR_BASE ?= 397159387476.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com
ECR_BASE=docker.pkg.github.com/celliott/starter-bundle
IMAGE_TAG ?= $(shell git log -n 1 --pretty=format:'%h')

# project vars
PROJECT ?= starter-bundle
ENVIRONMENT ?= staging
DOMAIN ?= toobox.io
NAMESPACE ?= starter-bundle

# API Vars
SERVICE ?= starter-bundle
API_NAME ?= starter-bundle-api
API_PORT ?= 3000
API_USER ?= admin
API_PASS ?= mypassword

# APP Vars
APP_NAME ?= starter-bundle-frontend
APP_PORT ?= 5000
STARTER_BUNDLE_SECRET ?= nosecret

export

include defaults.mk

check-env :

	@if [ -z $(ENVIRONMENT) ]; then \
		echo "ENVIRONMENT must be set; export ENVIRONMENT=<env>"; exit 10; \
	fi

ecr-init :
	$$(aws ecr get-login --no-include-email --region=${AWS_DEFAULT_REGION})

docker-config :
	docker-compose config --quiet

docker-build : docker-config
	docker-compose build

docker-up : docker-init
	docker-compose up -d

docker-down :
	docker-compose down

docker-push : ecr-init docker-build
	docker-compose push

helm-deploy :
	-helm init
	-kubectl create namespace $(SERVICE)
	helm upgrade -i $(NAMESPACE) helm/$(SERVICE) \
		--namespace $(NAMESPACE) \
		--set build.tag=$(IMAGE_TAG) \
		--set frontend.ingress.hostname=$(SERVICE).$(DOMAIN) \
		--set apiPass=$(API_PASS) \
		--set secret=$(STARTER_BUNDLE_SECRET)

helm-delete : init
	helm del --purge $(SERVICE)

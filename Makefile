include defaults.mk
export

init :
	-helm init --upgrade

config : init
	docker-compose config --quiet

build : config
	docker-compose build

up : init
	docker-compose up -d

down :
	docker-compose down

push : build
	docker-compose push

deploy : init
	-helm init
	-kubectl create namespace $(SERVICE)
	helm upgrade -i $(NAMESPACE) helm/$(SERVICE) \
		--namespace $(NAMESPACE) \
		--set build.tag=$(IMAGE_TAG) \
		--set frontend.ingress.hostname=$(SERVICE).$(DOMAIN) \
		--set apiPass=$(API_PASS) \
		--set secret=$(STARTER_BUNDLE_SECRET)

delete : init
	helm del --purge $(SERVICE)

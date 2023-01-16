TAG := $(GITHUB_REF)
ifeq ($(TAG),)
	TAG := $(shell git symbolic-ref --short -q HEAD)
endif
ifeq ($(TAG),)
	TAG := $(shell git rev-parse --short --verify HEAD)
endif

define docker_build_and_push
	docker buildx build \
		--push \
		--platform linux/arm64,linux/amd64 \
		-t "mrcs2000/$1:$(if $2,$2,$(TAG))" \
		./$1
endef

help:
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[0-9a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-18s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)
	@echo $(TAG)

all: freeradius mysql-backup-s3 nodejs octave opencv postgres-backup-s3 postgres-restore-s3 ## Build all images

.PHONY: freeradius
nodejs: ## Build freeradius image
	$(call docker_build_and_push,freeradius)

.PHONY: mysql-backup-s3
mysql-backup-s3: ## Build mysql-backup-s3 image
	$(call docker_build_and_push,mysql-backup-s3)

.PHONY: nodejs
nodejs: ## Build nodejs image
	$(call docker_build_and_push,nodejs)

.PHONY: octave
octave: ## Build octave image
	$(call docker_build_and_push,octave)

.PHONY: opencv
opencv: ## Build opencv image
	$(call docker_build_and_push,opencv)

.PHONY: postgres-backup-s3
postgres-backup-s3: ## Build postgres-backup-s3 image
	$(call docker_build_and_push,postgres-backup-s3)

.PHONY: postgres-restore-s3
postgres-restore-s3: ## Build postgres-restore-s3 image
	$(call docker_build_and_push,postgres-restore-s3)
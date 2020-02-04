.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

check_defined = \
				$(strip $(foreach 1,$1, \
				$(call __check_defined,$1,$(strip $(value 2)))))
__check_defined = \
				  $(if $(value $1),, \
				  $(error Undefined $1$(if $2, ($2))$(if $(value @), \
				  required by target `$@')))

.PHONY: build
build: ## Run docker-compose build of the DIR (ex. DIR=postgres).
	@:$(call check_defined, DIR, directory of the docker-compose)
	@$(CURDIR)/build.sh "$(CURDIR)/$(DIR)"

.PHONY: up
up: ## Run docker-compose up of the DIR (ex. DIR=postgres).
	@:$(call check_defined, DIR, directory of the docker-compose)
	@$(CURDIR)/up.sh "$(CURDIR)/$(DIR)"

.PHONY: down
down: ## Run docker-compose down of the DIR (ex. DIR=postgres).
	@:$(call check_defined, DIR, directory of the docker-compose)
	@$(CURDIR)/down.sh "$(CURDIR)/$(DIR)"

.PHONY: logs
logs: ## Run docker-compose logs -f of the DIR (ex. DIR=postgres).
	@:$(call check_defined, DIR, directory of the docker-compose)
	@$(CURDIR)/logs.sh "$(CURDIR)/$(DIR)"

.PHONY: restart
restart: down up	## Run docker-compose down & up of the DIR (ex. DIR=postgres).
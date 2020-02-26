DIR = $(shell command ls -d */ | cut -d '/' -f 1;)

define printf
  @echo $(1) $(2) | awk '{target=$$1":";sub(".*"$$2,$$2);printf "\033[36m%-30s\033[0m %s\n", target, $$0}'
endef

.PHONY: help
help:
	$(call printf, DIR.build, "Run docker-compose build of the DIR (ex. postgres.build).")
	$(call printf, DIR.up, "Run docker-compose up of the DIR (ex. postgres.up).")
	$(call printf, DIR.down, "Run docker-compose down of the DIR (ex. postgres.down).")
	$(call printf, DIR.logs, "Run docker-compose logs -f of the DIR (ex: postgres.logs).")
	$(call printf, DIR.restart, " Run docker-compose down & up of the DIR (ex: postgres.restart).")

.PHONY: $(DIR).build
$(DIR).build:
	@$(CURDIR)/build.sh "$(CURDIR)/$(DIR)"

.PHONY: $(DIR).up
$(DIR).up:
	@$(CURDIR)/up.sh "$(CURDIR)/$(DIR)"

.PHONY: $(DIR).down
$(DIR).down:
	@$(CURDIR)/down.sh "$(CURDIR)/$(DIR)"

.PHONY: $(DIR).logs
$(DIR).logs:
	@$(CURDIR)/logs.sh "$(CURDIR)/$(DIR)"

.PHONY: $(DIR).restart
$(DIR).restart: $(DIR).down $(DIR).up
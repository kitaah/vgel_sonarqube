.PHONY: ps build up start fresh stop restart down destroy

CONTAINER_SONAR=sonarqube
CONTAINER_DATABASE=db_postgres-database
VOLUME_DATABASE_DATA=vgel_sonarqube_postgres_database_data
VOLUME_BUNDLED_PLUGINS=vgel_sonarqube_sonarqube_bundled-plugins
VOLUME_CONF=vgel_sonarqube_sonarqube_conf
VOLUME_DATA=vgel_sonarqube_sonarqube_data
VOLUME_DATABASE=vgel_sonarqube_postgres_database
VOLUME_EXTENSIONS=vgel_sonarqube_sonarqube_extensions
VOLUME_LOGS=vgel_sonarqube_sonarqube_logs

ps: ## Show containers
	@docker-compose ps
build: ## Build all containers
	@docker-compose-build
up: ##  Builds, (re)creates, and starts containers
	@docker-compose up
start: ## Start all containers
	@docker-compose up
fresh: stop destroy build start ## Destroy & recreate all containers
stop: ## Stop all containers
	@docker-compose stop
down: ## Stop and remove all containers
	@docker-compose down
restart: stop start ## Restart all containers
destroy: stop ## Destroy all containers
	@docker-compose down
	@if [ "$(shell docker volume ls --filter name=${VOLUME_DATABASE_DATA} --format {{.Name}})" ]; then \
		docker volume rm ${VOLUME_DATABASE_DATA}; \
	fi

	@if [ "$(shell docker volume ls --filter name=${VOLUME_BUNDLED_PLUGINS} --format {{.Name}})" ]; then \
		docker volume rm ${VOLUME_BUNDLED_PLUGINS}; \
	fi

	@if [ "$(shell docker volume ls --filter name=${VOLUME_CONF} --format {{.Name}})" ]; then \
		docker volume rm ${VOLUME_CONF}; \
	fi

	@if [ "$(shell docker volume ls --filter name=${VOLUME_DATA} --format {{.Name}})" ]; then \
		docker volume rm ${VOLUME_DATA}; \
	fi

	@if [ "$(shell docker volume ls --filter name=${VOLUME_DATABASE} --format {{.Name}})" ]; then \
		docker volume rm ${VOLUME_DATABASE}; \
	fi

	@if [ "$(shell docker volume ls --filter name=${VOLUME_EXTENSIONS} --format {{.Name}})" ]; then \
		docker volume rm ${VOLUME_EXTENSIONS}; \
	fi

sonar-install: ## Install SonarScanner last version
	./scripts/install-sonar-scanner.sh
sonar-scan: ## Run SonarScanner last version
	/var/opt/sonar-scanner-4.8.0.2856-linux/bin/sonar-scanner \
		-Dsonar.projectKey=vgel \
		-Dsonar.sources=. \
		-Dsonar.sourceEncoding=utf-8 \
		-Dsonar.host.url=http://127.0.0.1:9000 \
		-Dsonar.login=sqp_3813d01c9a0f11e604d622811cc15f8451fb2fa2
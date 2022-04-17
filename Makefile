DOCKER_RUN?=docker-compose run -u www-data --rm php

.PHONY: setup
setup:
	cp .env .env.local
	make install-composer
	docker-compose up -d
	make vendor

.PHONY: install-composer
install-composer:
	$(DOCKER_RUN) php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
	$(DOCKER_RUN) php -r "if (hash_file('sha384', 'composer-setup.php') === '906a84df04cea2aa72f40b5f787e49f22d4c2f19492ac310e8cba5b96ac8b64115ac402c8cd292b8a03482574915d1a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
	$(DOCKER_RUN) php composer-setup.php
	$(DOCKER_RUN) php -r "unlink('composer-setup.php');"

.PHONY: up
up:
	docker-compose up -d
	docker-compose run -p 8000:8000 php php -S 0.0.0.0:8000 -t public

.PHONY: down
down:
	docker-compose down --remove-orphans

.PHONY: stop
stop:
	docker-compose stop

.PHONY: vendor
vendor:
	$(DOCKER_RUN) ./composer.phar install
	$(DOCKER_RUN) bin/console cache:warmup

.PHONY: test
test:
	$(DOCKER_RUN) bin/phpspec run
	$(DOCKER_RUN) bin/simple-phpunit tests/

.PHONY: heroku
heroku:
	heroku config:set SYMFONY_ENV=prod APP_ENV=prod
	git push heroku main

dev:
	docker-compose -f docker-compose-dev.yml up -d

prod:
	docker-compose up -d --build

stop:
	docker-compose down
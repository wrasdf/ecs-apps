.PHONY: build run

DCR := docker-compose run --rm
%-dev: environment := dev

build:
	docker build -t node-rds:latest .

run:
	docker run --rm -d -p 3000:3000 node-rds:latest

teardown:
	docker stop $(shell docker ps -aq)

cfn-verify-rds:
	$(DCR) aws cloudformation validate-template --template-body file://cfn/rds.yaml

cfn-rds-%: cfn-verify-rds
	$(DCR) stackup APP-RDS-Postgres up -t ./cfn/rds.yaml -p ./cfn/params/$(environment).yaml

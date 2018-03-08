.PHONY:

DCR := docker-compose run --rm
%-dev: environment := dev

cfn-verify-vpc:
	$(DCR) aws cloudformation validate-template --template-body file://infrastructure/vpc.yaml

cfn-verify-cluster:
	$(DCR) aws cloudformation validate-template --template-body file://infrastructure/cluster.yaml

# cfn-verify-ecs-service:
# 	$(DCR) aws cloudformation validate-template --template-body file:///infrastructure/ECS-cloudformation/service.yaml

cfn-vpc-%: cfn-verify-vpc
	$(DCR) stackup ECS-Stack-VPC up -t ./infrastructure/vpc.yaml -p ./infrastructure/params/$(environment)/vpc.yaml

cfn-cluster-%: cfn-verify-cluster
	$(DCR) stackup ECS-Stack-Cluster up -t ./infrastructure/cluster.yaml -p ./infrastructure/params/$(environment)/cluster.yaml

# cfn-ecs-service: cfn-verify-ecs-service
# 	$(DCR) stackup myECS-Stack-service up -t ./ECS-cloudformation/service.yaml -p ./ECS-cloudformation/params/dev/service.yaml

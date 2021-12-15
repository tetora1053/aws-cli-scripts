#!/bin/bash

CLUSTER_NAME=$(aws ecs list-clusters --output text --query "clusterArns[0]")
TASK_DEFINITION=$(aws ecs list-task-definitions --output text --query "taskDefinitionArns[0]")
VPC_ID=$(aws ec2 describe-vpcs --filters "Name=tag-value, Values=EcsClusterQaBotStack/EcsClusterQaBot-Vpc" --output text --query "Vpcs[].VpcId")
SUBNET_ID=$(aws ec2 describe-subnets --output text --query "Subnets[?VpcId==\`${VPC_ID}\`].SubnetId | [0]")
CONTEXT="A giant peach was flowing in the river. She picked it up and brought it home. Later, a healthy baby was born from the peach. She named the baby Momotaro."
QUESTION="What is the name of the baby?"
ITEM_ID=$(uuidgen)
aws ecs run-task \
  --cluster ${CLUSTER_NAME} \
  --task-definition ${TASK_DEFINITION} \
  --count 1 \
  --launch-type FARGATE \
  --network-configuration=awsvpcConfiguration="{subnets=${SUBNET_ID}, assignPublicIp=ENABLED}" \
  --overrides=containerOverrides="[{name=EcsClusterQaBot-Container, command=[\"${CONTEXT}\", \"${QUESTION}\", ${ITEM_ID}]}]"


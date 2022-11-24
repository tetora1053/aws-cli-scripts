#!/bin/bash
#
# Create and associate SG which allows specified IP to access to the specified EC2 instance.
# The SG created by this script must be deleted later.
#
# Usage:
#   export INSTANCE_NAME=hoge
#   export IP_ADDR=xxx.xxx.xxx.xxx
#

VPC_ID=$(aws ec2 describe-vpcs \
  --filters Name=tag:Name,Values=BaseVPC/VPC \
  --query 'Vpcs[].VpcId' \
  --output text
)

# create SecurityGroup
SG_ID=$(
  aws ec2 create-security-group \
    --group-name must-be-deleted \
    --description tmp \
    --vpc-i ${VPC_ID} \
    --query 'GroupId' \
    --output text
)

# ingress rules for specified IP
aws ec2 authorize-security-group-ingress \
  --group-id ${SG_ID} \
  --protocol tcp \
  --port 80 \
  --cidr ${IP_ADDR}/32

aws ec2 authorize-security-group-ingress \
  --group-id ${SG_ID} \
  --protocol tcp \
  --port 443 \
  --cidr ${IP_ADDR}/32

INSTANCE_ID=$(
  aws ec2 describe-instances \
    --filters Name=tag:Name,Values=${INSTANCE_NAME} \
    --query 'Reservations[].Instances[].InstanceId' \
    --output text
)

# get current SecurityGroups to add another one
CURRENT_SG_IDS=$(
  aws ec2 describe-instance-attribute \
    --instance-id ${INSTANCE_ID} \
    --attribute groupSet --query 'Groups[].GroupId' \
    --output text
)

# add SecurityGroup
aws ec2 modify-instance-attribute \
  --instance-id ${INSTANCE_ID} \
  --groups ${CURRENT_SG_IDS} ${SG_ID}

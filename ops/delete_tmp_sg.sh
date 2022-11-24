#!/bin/bash
#
# Delete SG created by allow_ip_tmporary_access_to_ec2.sh
#
# Usage:
#   export INSTANCE_NAME=hoge
#

INSTANCE_ID=$(
  aws ec2 describe-instances \
    --filters Name=tag:Name,Values=${INSTANCE_NAME} \
    --query "Reservations[].Instances[].InstanceId" \
    --output text
)

# get original SGs
ORG_SGS=$(
  aws ec2 describe-instances \
    --filters Name=tag:Name,Values=${INSTANCE_NAME} \
    --query "Reservations[].Instances[].SecurityGroups[? GroupName != \`must-be-deleted\`].GroupId" \
    --output text
)

# detach tmp SG from instance
aws ec2 modify-instance-attribute \
  --instance-id ${INSTANCE_ID} \
  --groups ${ORG_SGS}

TMP_SG_ID=$(
  aws ec2 describe-security-groups \
    --query "SecurityGroups[? GroupName == \`must-be-deleted\`].GroupId" \
    --output text
)

aws ec2 delete-security-group \
  --group-id ${TMP_SG_ID}

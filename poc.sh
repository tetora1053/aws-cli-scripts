#!/bin/bash


instance_ids=$(aws ec2 describe-instances --query "Reservations[].Instances[].InstanceId" --output text)

for instance_id in $instance_ids; do
  res=$(aws ec2 describe-instance-attribute --attribute disableApiStop --instance-id $instance_id --output json)
  echo $res | jq -r '"\(.InstanceId) \(.DisableApiStop.Value)"' >> list.txt
done

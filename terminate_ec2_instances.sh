
INSTANCE_IDS=$(aws ec2 describe-tags --filters \
    "Name=resource-type,Values=instance" \
    "Name=value,Values=${TARGET_INSTANCE_NAME}" --output json | jq -r '.Tags[].ResourceId'
)
STR=""
for INSTANCE_ID in ${INSTANCE_IDS}
do
    STR+="${INSTANCE_ID} "
done
echo ${STR}
aws ec2 terminate-instances --instance-ids ${STR}
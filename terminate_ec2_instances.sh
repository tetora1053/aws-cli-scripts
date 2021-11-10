
INSTANCE_IDS=$(aws ec2 describe-tags --filters \
    "Name=resource-type,Values=instance" \
    "Name=value,Values=${TARGET_INSTANCE_NAME}" --output json | jq -r '.Tags[].ResourceId'
)
# TODO:複数対応
# aws ec2 terminate-instances --instance-ids "id-xxxxxxxx" "id-yyyyyyyy"
aws ec2 terminate-instances --instance-ids "${INSTANCE_IDS}"
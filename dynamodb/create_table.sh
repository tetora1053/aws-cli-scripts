## create table

TABLE_NAME="test"
ATTRIBUTE_NAME_1="attr1"
ATTRIBUTE_NAME_2="attr2"

# B / N / S
ATTRIBUTE_TYPE_1="S"
ATTRIBUTE_TYPE_2="S"

# HASH / RANGE
KEY_TYPE_HASH="HASH"
KEY_TYPE_RANGE="RANGE"

# PAY_PER_REQUEST / PROVISIONED
BILLING_MODE="PAY_PER_REQUEST"

aws dynamodb create-table \
  --table-name ${TABLE_NAME} \
  --attribute-definitions \
    "AttributeName=${ATTRIBUTE_NAME_1},AttributeType=${ATTRIBUTE_TYPE_1}" \
    "AttributeName=${ATTRIBUTE_NAME_2},AttributeType=${ATTRIBUTE_TYPE_2}" \
  --key-schema \
    "AttributeName=${ATTRIBUTE_NAME_1},KeyType=${KEY_TYPE_HASH}" \
    "AttributeName=${ATTRIBUTE_NAME_2},KeyType=${KEY_TYPE_RANGE}" \
  --billing-mode ${BILLING_MODE}

# send message to sns topic

REGION=$(aws configure get region)
ACCOUNT_ID=$(aws sts get-caller-identity --output json | jq -r ".Account")
aws sns publish --message "hello sns" --topic-arn arn:aws:sns:ap-northeast-1:${ACCOUNT_ID}:${TOPIC_NAME}
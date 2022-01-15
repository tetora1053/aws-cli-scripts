#!/bin/bash

LAMBDA_NAME=tetoraFuncA

cat << EOF > lambda_function.py
import json

def handler(event, context):
    print("${LAMBDA_NAME}")
    return "0"

EOF

zip lambda_function.zip lambda_function.py
aws lambda create-function --function-name ${LAMBDA_NAME} --runtime python3.7 --role ${ROLE_ARN} --zip-file file://lambda_function.zip --handler lambda_function.handler
rm lambda_function.zip lambda_function.py

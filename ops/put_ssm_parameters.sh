#!/bin/bash -x
#
# put SSM ParameterStore key-values.
# multiple parameters can be put at once
#
# Usage:
#   put_ssm_parameters.sh [NAME1]=[VALUE1] [NAME2]=[VALUE2] ...
#
# TODO:
#   - case when names or values of parameters including ' ', '=', or other special characters
#   - supoprt for String or StringList parameters. All parameters is put as SecureString now.
#

for ARG in ${@};
do
  NAME=$(echo ${ARG} | cut -d= -f1)
  VAL=$(echo ${ARG} | cut -d= -f2)
  PARAM_TYPE=SecureString

  aws ssm put-parameter \
    --name ${NAME} \
    --value ${VAL} \
    --type ${PARAM_TYPE} \
    --overwrite
done

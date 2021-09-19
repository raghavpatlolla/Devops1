#!/bin/bash
COMPONENT=$1
LTVER=2
LTId=lt-0d5e63f293cae8014

if [ -z "${COMPONENT}" ]; then
echo "COMPONENT input is Needed"
exit 1

fi

  INSTANCE_STATE=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${COMPONENT}"  | jq .Reservations[].Instances[].State.Name | xargs -n1)


for row in $(echo "${INSTANCE_STATE}" | jq -r '.[] | @base64'); do
    _jq() {
     echo ${row} | base64 --decode | jq -r ${1}
    }
   echo $(_jq '.name')
done
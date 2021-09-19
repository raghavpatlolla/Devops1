#!/bin/bash
COMPONENT=$1
LTVER=2
LTId=lt-0d5e63f293cae8014

if [ -z "${COMPONENT}" ]; then
echo "COMPONENT input is Needed"
exit 1

fi




  STATE_CODE=$(aws ec2 describe-instances     --filters Name=tag:Name,Values=frontend  | jq .Reservations[].Instances[].State.Code| xargs)

echo ${STATE_CODE}


   for  STATE in "${STATE_CODE[@]}"; do
     echo "now the state is ${STATE}"
done


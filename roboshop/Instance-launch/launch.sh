#!/bin/bash
COMPONENT=$1
LTVER=2
LTId=lt-0d5e63f293cae8014

if [ -z "${COMPONENT}" ]; then
echo "COMPONENT input is Needed"
exit 1

fi



  INSTANCE_EXISTS=$(aws ec2 describe-instances --filters Name=tag:Name,Values=${COMPONENT}  | jq .Reservations[])
  STATE=$(aws ec2 describe-instances     --filters Name=tag:Name,Values=frontend  | jq .Reservations[].Instances[].State.Code)

echo ${STATE}

  if [ "$STATE" == "48"  ]; then
   echo "Instance Terminated "
   echo ${STATE}
  else
    echo "Instance ${COMPONENT} not exists"
  fi
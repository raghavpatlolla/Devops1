#!/bin/bash
COMPONENT=$1
LTVER=2
LTId=lt-0d5e63f293cae8014

if [ -z "${COMPONENT}" ]; then
echo "COMPONENT input is Needed"
exit 1

fi

allThreads=(1 2 4 8 16 32 64 128)

  INSTANCE_EXISTS=$(aws ec2 describe-instances --filters Name=tag:Name,Values=${COMPONENT}  | jq .Reservations[])
  STATE=$(aws ec2 describe-instances     --filters Name=tag:Name,Values=frontend  | jq .Reservations[].Instances[].State.Code)

echo ${STATE}

t_count=0
exists_count=0
   for  STATE in "${INSTANCE_EXISTS[@]}"; do
     if [ "$STATE" == "48"  ]; then
   echo "Instance Terminated "
      t_count=t_count+1
      echo "$STATE"
   else
     echo "Instance ${COMPONENT} not exists "
     exists_count=exists_count+1
     echo "$STATE"
   fi
done

echo " t_count $t_count"
echo " exists_count $exists_count"

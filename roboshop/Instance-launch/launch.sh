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

t_count=0
exists_count=0
   for  STATE in "${STATE_CODE[@]}"; do
     if [ "$STATE" == 48  ]; then
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

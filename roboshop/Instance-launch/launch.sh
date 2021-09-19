#!/bin/bash
COMPONENT=$1
LTVER=2
LTId=lt-0d5e63f293cae8014

if [ -z "${COMPONENT}" ]; then
echo "COMPONENT input is Needed"
exit 1

fi

  INSTANCE_STATE=$(aws ec2 describe-instances     --filters Name=tag:Name,Values=${COMPONENT}  | jq .Reservations[].Instances[].State.Code | xargs )
t_count=0
exists_count=0
STATE_STRING=$(echo  "$INSTANCE_STATE"| sed -e 's/\[ //g' -e 's/\ ]//g' -e 's/\,//g')
arr=( $STATE_STRING)
for STATE in ${arr[@]}; do
     if [ "$STATE" == 48  ]; then
      t_count=`expr $t_count + 1`
    else
     exists_count=`expr $exists_count + 1`
      fi
done

if [ "$exists_count" -gt 0 ]; then
echo "Instance ${COMPONENT} already exists "
exit 0
else
  echo "Instance ${COMPONENT} not exists "
fi

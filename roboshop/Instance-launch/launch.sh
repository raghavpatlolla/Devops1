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
echo  "$INSTANCE_STATE"
borkstring=$(echo  "$INSTANCE_STATE"| sed -e 's/\[ //g' -e 's/\ ]//g' -e 's/\,//g')
arr=( $borkstring )
for STATE in ${arr[@]}; do
    echo ${STATE//\"}
    if [ "$STATE" == 48  ]; then
   echo "Instance Terminated "
      t_count=`expr $t_count + 1`
      echo "$STATE"
   else
     echo "Instance ${COMPONENT} not exists "
     exists_count=`expr $exists_count + 1`
     echo "$STATE"
   fi
done

echo " t_count $t_count"
echo " exists_count $exists_count"
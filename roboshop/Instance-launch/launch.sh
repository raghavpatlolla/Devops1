#!/bin/bash
COMPONENT=$1
LTVER=2
LTId=lt-0d5e63f293cae8014

if [ -z "${COMPONENT}" ]; then
echo "COMPONENT input is Needed"
exit 1

fi
#set hostname
hostnamectl set-hostname  "${COMPONENT}"
DNS_UPDATE(){

  PRIVATE_IP=$(aws ec2 describe-instances     --filters Name=tag:Name,Values=frontend | jq .Reservations[].Instances[].PrivateIpAddress|xargs -n1)
  sed -e "s/COMPONENT/${COMPONENT}/" -e "s/PRIVATE_IP/${PRIVATE_IP}/" DNS_update_record.json> /tmp/DNS_update_record.json
  aws route53 change-resource-record-sets --hosted-zone-id Z032055624YJMWSH9HS8R --change-batch file:///tmp/DNS_update_record.json|jq
}


INSTANCE_STATE=$(aws ec2 describe-instances     --filters Name=tag:Name,Values=${COMPONENT}  | jq .Reservations[].Instances[].State.Code | xargs )
###INSTANCE_STATE is JSON array
###Converting a JSON array to a bash array
#### strip out all the things you don't want - square brackets and commas
STATE_STRING=$(echo  "$INSTANCE_STATE"| sed -e 's/\[ //g' -e 's/\ ]//g' -e 's/\,//g')
arr=( $STATE_STRING)
## arr is bash array
## looping bash arry and counting the instance code
##0 : pending
##16 : running
##32 : shutting-down
##48 : terminated
##64 : stopping
##80 : stopped
t_count=0  # terminated state instance count
exists_count=0 #Other instance state count
for STATE in ${arr[@]}; do
     if [ "$STATE" == 48  ]; then
      t_count=`expr $t_count + 1`
    else
     exists_count=`expr $exists_count + 1`
      fi
done

if [ "$exists_count" -gt 0 ]; then
echo "Instance ${COMPONENT} already exists "
DNS_UPDATE
exit 0
else
  echo "Instance ${COMPONENT} not exists...creating ${COMPONENT} instance"
  aws ec2 run-instances --launch-template LaunchTemplateId=${LTId},Version=${LTVER} --tag-specifications "ResourceType=instance ,Tags=[{Key=Name,Value=${COMPONENT}}]"
  aws ec2 wait instance-exists   --filters Name=tag:Name,Values=${COMPONENT}  | jq .Reservations[].Instances[].InstanceId
  DNS_UPDATE
fi




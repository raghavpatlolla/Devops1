#!/bin/bash
COMPONENT=$1
LTVER=2
LTId=lt-0d5e63f293cae8014

if [ -z "${COMPONENT}" ]; then
echo "COMPONENT input is Needed"
exit 1

fi
aws ec2 run-instances --launch-template LaunchTemplateId=${LTId},Version=${LTVER} --tag-specifications "ResourceType=instance ,Tags=[{Key=Name,Value=${COMPONENT}}]"|jq
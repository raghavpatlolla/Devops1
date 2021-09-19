#!/bin/bash
COMPONENT=$1
LTVER=2
LTId=lt-0d5e63f293cae8014

if [ -z "${COMPONENT}" ]; then
echo "COMPONENT input is Needed"
exit 1

fi

  INSTANCE_STATE=$(aws ec2 describe-instances     --filters Name=tag:Name,Values=${COMPONENT}  | jq .Reservations[].Instances[].State.Code | xargs )



echo  "$INSTANCE_STATE"
borkstring=$(echo  "$INSTANCE_STATE"| sed -e 's/\[ //g' -e 's/\ ]//g' -e 's/\,//g')
arr=( $borkstring )
for i in ${arr[@]}; do
    # add a little native bash quote-stripping in there; without it,
    # all your array elements will be wrapped in quotes.
    echo ${i//\"}
done


#! /usr/bin/env bash
# This script outputs all the Name Records of an AWS account in all hosted zone Ids



if [ $# != 1 ]; then
    echo -e "\n\e[0;31mPlease input AWS PROFILE in this format:\e\n"
    echo -e "\t\e[1;33m./$(basename "$0") default \e\n"
    exit 1
fi


AWS_PROFILE=$1


for i in $(aws route53 list-hosted-zones --query 'HostedZones[*].[Id]' --output text --profile $AWS_PROFILE | cut -d '/' -f 3)
do
    echo -e "\n\033[0;36m>>> ZONE ID,  $i:\n\033[0m"
    aws route53 list-resource-record-sets --hosted-zone-id $i --max-items 1000000 --query 'ResourceRecordSets[*].[Name]' --output text --profile $AWS_PROFILE
    echo -e "_________________\n"
done

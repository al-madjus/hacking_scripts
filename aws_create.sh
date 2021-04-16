#!/bin/bash
green="\e[0;32m"
red="\e[0;31m"
reset="\e[0m"

if [[ $# -eq 0 || $# -eq 1 ]] ; then
    echo -e "${green}Usage${reset}:\n aws.sh ${red}bucketname region${reset}"
    exit 0
fi

bucket=$1
region=$2

set -e -o pipefail

aws s3 mb s3://$bucket --region $region

aws s3 cp ~/Pentesting/tools/takeover/poc.html s3://$bucket
aws s3 cp ~/Pentesting/tools/takeover/raven.jpg s3://$bucket

aws s3api put-object-acl --bucket $bucket --key poc.html --acl public-read
aws s3api put-object-acl --bucket $bucket --key raven.jpg --acl public-read

echo -e "${green}https://$bucket.s3.$2.amazonaws.com/poc.html${reset}"

#!/bin/bash

###########################################################
# config
###########################################################
source="hello-from-api"
target="207086112514.dkr.ecr.us-east-1.amazonaws.com/app"
version="latest"

###########################################################
# main
###########################################################
eval $(aws ecr get-login --no-include-email --region us-east-1)
docker tag $source:$version $target:$version
docker push $target:$version

#!/bin/bash

###########################################################
# config
###########################################################
source="hello-from-api"
target="140539094451.dkr.ecr.us-west-2.amazonaws.com/ops/api"
version="latest"

###########################################################
# main
###########################################################
eval $(aws ecr get-login --no-include-email --region us-west-2)
docker tag $source:$version $target:$version
docker push $target:$version

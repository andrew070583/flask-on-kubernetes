#!/bin/bash
image="hello-from-api"
version="latest"
docker run -d -p 5000:5000 --restart unless-stopped $image:$version 

#!/bin/bash
#
#
#
#

set -e

if (( $# < 1 )); then	echo "Illegal number of parameters"
	echo "usage: services [build|test|push]"
	exit 1
fi

stoppingContainers () {
	docker stop html-page-01 || true && docker rm html-page-01 || true
}
displayServices () {
	CONTAINER=`docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" --filter name=html-*`
	if [[ $CONTAINER == *"html"* ]]; then
		echo "$CONTAINER"
		echo -e "\033[1;32m=========== TEST PASSED ===========\033[0m"
	else
		echo -e "\033[1;31m=========== TEST FAILED ===========\033[0m"
	fi
}


command="$1"
case "${command}" in
	"help")
		echo "usage: services [build|test|push]"
		;;
	"test")
		stoppingContainers
		displayServices
		echo -e "Starting container: \033[1;34mhtml-page-01\033[0m"
		docker run -d --name html-page-01 -p 80:80 static-html-page-image
		displayServices
		;;
	"push")
		echo -e "pushed the Docker image to Docker Hub..."
		docker push scharfeddine/static-html-page-image:latest
		;;
	"build")
		echo "Build image using Dockerfile"
		docker build -t static-html-page-image .
		;;
	*)
		echo "Command not Found."
		echo "usage: services [create|start|stop]"
		exit 127;
		;;
esac

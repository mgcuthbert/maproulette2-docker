#!/bin/bash
export VERSION=$1
echo "Stopping and removing maproulette api container"
RUNNING=$(docker inspect --format="{{ .State.Running }}" maproulette-api 2> /dev/null)
if [[ $? -eq 0 ]]; then
  docker stop maproulette-api || true && docker rm maproulette-api || true
fi
echo "Starting maproulette api container"
docker run -t --privileged \
        -d -p 9000:9000 \
        --name maproulette-api \
        -dit --restart unless-stopped \
        --network mrnet \
        maproulette/maproulette-api:${VERSION}
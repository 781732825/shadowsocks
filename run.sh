#!/bin/bash
SERVER_PORT=8111
CLIENT_PORT=8010

OUTPUT=$(docker build --build-arg CACHE_DATE=$(date +%Y-%m-%d:%H:%M:%S) . | tee /dev/tty)
ID=$(echo "$OUTPUT" | tail -n 1 | awk '{print $3}')

if [[ "$1" == "c" ]]; then
echo "run client"
docker run -p $CLIENT_PORT:$CLIENT_PORT -p $CLIENT_PORT:$CLIENT_PORT/udp -i -t $ID sslocal -c test.json
else
echo "run server"
docker run -p $SERVER_PORT:$SERVER_PORT -p $SERVER_PORT:$SERVER_PORT/udp -i -t $ID ssserver -c test.json
fi

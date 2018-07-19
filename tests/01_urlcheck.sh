#!/bin/sh

for i in $(seq 1 5);
do
    curl http://localhost:8000/ | grep -q "Read the Docs" && result=0 && break \
    || result=$? && sleep 5;
done;
(exit $result)
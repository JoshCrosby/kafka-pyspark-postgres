#!/bin/bash

# Build the Docker image
docker build -t kafka-pyspark-consumer ./docker

# Run the consumer application within the Docker container
docker run --network="host" kafka-pyspark-consumer

# Makefile for Kafka-PySpark-Postgres Project

# Project variables
COMPOSE_FILE := docker-compose.yml
NETWORK_NAME := kafka-network

.PHONY: up down clean build network prune

# Build the Docker images without starting the containers
build:
	docker-compose -f $(COMPOSE_FILE) build

# Start all services in the background
up: network build
	docker-compose -f $(COMPOSE_FILE) up -d

# Stop all services
down:
	docker-compose -f $(COMPOSE_FILE) down

# Remove all containers, networks, and volumes
clean: down
	docker-compose -f $(COMPOSE_FILE) down --volumes --remove-orphans
	docker network rm $(NETWORK_NAME) || true

# Create the network if it doesn't already exist
network:
	@docker network ls | grep $(NETWORK_NAME) || docker network create $(NETWORK_NAME)

# Prune Docker system to remove unused data
prune:
	docker system prune -f

# Display help information
help:
	@echo "Makefile for managing the Kafka-PySpark-Postgres project"
	@echo ""
	@echo "Usage:"
	@echo "  make build       Build the Docker images without starting the containers."
	@echo "  make up          Start all services in the background."
	@echo "  make down        Stop all services."
	@echo "  make clean       Remove all containers, networks, and volumes."
	@echo "  make network     Create the custom network if it doesn't exist."
	@echo "  make prune       Prune Docker system to remove unused data."
	@echo "  make help        Display this help information."

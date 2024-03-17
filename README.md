# Kafka-PySpark-Postgres Project

This project demonstrates a Dockerized setup for processing Kafka messages using PySpark and logging them into a PostgreSQL database.

## Setup

1. Ensure Docker and Docker Compose are installed on your system.
2. Clone this repository to your local machine.
3. Navigate to the project directory and run `docker-compose up --build` to start the services.
4. The PySpark application will automatically start consuming messages from Kafka and log them into the PostgreSQL database.

## Components

- **Zookeeper & Kafka**: For message queuing.
- **PostgreSQL**: For storing processed messages.
- **PySpark Consumer**: For consuming and processing Kafka messages.

## Configuration

Modify the `docker-compose.yml` file to change service configurations as needed. Update the PySpark script (`src/main.py`) to adjust Kafka topic subscriptions and PostgreSQL table names.

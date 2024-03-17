FROM jupyter/pyspark-notebook:latest

USER root

# Install Java for Kafka
RUN apt-get update && \
    apt-get install -y default-jdk

# Install PostgreSQL JDBC Driver
RUN curl -s https://jdbc.postgresql.org/download/postgresql-42.2.9.jar -o /usr/local/spark/jars/postgresql-42.2.9.jar

USER $NB_UID

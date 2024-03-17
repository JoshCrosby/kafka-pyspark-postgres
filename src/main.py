from pyspark.sql import SparkSession

def create_spark_session():
    return SparkSession.builder \
        .appName("KafkaConsumerToPostgres") \
        .getOrCreate()

def consume_messages(spark, kafka_bootstrap_servers, postgres_url, postgres_user, postgres_password):
    df = spark \
        .readStream \
        .format("kafka") \
        .option("kafka.bootstrap.servers", kafka_bootstrap_servers) \
        .option("subscribe", "myTopc") \
        .load()

    df_string = df.selectExpr("CAST(value AS STRING) as message")

    query = df_string.writeStream \
        .foreachBatch(lambda batch_df, _: batch_df.write \
                      .format("jdbc") \
                      .option("url", postgres_url) \
                      .option("dbtable", "messages") \
                      .option("user", postgres_user) \
                      .option("password", postgres_password) \
                      .mode("append") \
                      .save()) \
        .start()

    query.awaitTermination()

if __name__ == "__main__":
    spark = create_spark_session()
    kafka_bootstrap_servers = "kafka:9092"
    postgres_url = "jdbc:postgresql://postgres:5432/kafka_messages"
    postgres_user = "user"
    postgres_password = "password"

    consume_messages(spark, kafka_bootstrap_servers, postgres_url, postgres_user, postgres_password)

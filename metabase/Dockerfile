FROM openjdk:19-buster

ARG METABASE_VERSION=latest
ARG METABASE_DUCKDB_VERSION=0.2.6

ENV MB_PLUGINS_DIR=/home/plugins/

ADD https://downloads.metabase.com/${METABASE_VERSION}/metabase.jar /home
ADD https://github.com/AlexR2D2/metabase_duckdb_driver/releases/download/${METABASE_DUCKDB_VERSION}/duckdb.metabase-driver.jar /home/plugins/

RUN chmod 744 /home/plugins/duckdb.metabase-driver.jar

CMD ["java", "-jar", "/home/metabase.jar"]

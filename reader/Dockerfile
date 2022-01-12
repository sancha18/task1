FROM ubuntu

WORKDIR /app

RUN apt-get update
RUN apt-get install -y netcat mariadb-client-core-10.3 curl

COPY reader_script.sh ./
COPY server.sh ./

CMD ./reader_script.sh
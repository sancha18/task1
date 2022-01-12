FROM ubuntu

WORKDIR /app

RUN apt-get update
RUN apt-get install -y netcat mariadb-client-core-10.3 curl

COPY writer_script.sh ./

CMD ./writer_script.sh
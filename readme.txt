
1. Install minikube and start it:
minikube start

2. (to get docker image from local rep need this) Enable the container environment inside minikube with docker-env to use it on your local computer.
minikube docker-env

3. (to get docker image from local rep need this) Execute the given command.
eval $(minikube docker-env)

4. build image writerdockerise
cd wirter
docker build -t writerdockerise .

5. build image readerdockerise
cd reader
docker build -t readerdockerise .

6 in new terminal
6.1 start configmap
kubectl create -f configmap-mariadb-master.yml
kubectl create -f configmap-prometheus.yml

kubectl create -f configmap-mariadb-master.yml && kubectl create -f configmap-prometheus.yml

6.2 start services
kubectl create -f service-mariadb.yml
kubectl create -f service-mariadb-slave.yml
kubectl create -f service-reader.yml
kubectl create -f service-prometheus.yml 
kubectl create -f service-grafana.yml 
kubectl create -f service-pushgateway.yml

kubectl create -f service-mariadb.yml && kubectl create -f service-mariadb-slave.yml && kubectl create -f service-reader.yml && kubectl create -f service-prometheus.yml && kubectl create -f service-grafana.yml && kubectl create -f service-grafana.yml && kubectl create -f service-pushgateway.yml

6.2 start deployments
kubectl create -f deploy-mariadb-master.yml
kubectl create -f deploy-mariadb-slave.yml
kubectl create -f deploy-writer.yml
kubectl create -f deploy-reader.yml
kubectl create -f deploy-prometheus.yml
kubectl create -f deploy-grafana.yml 
kubectl create -f deploy-pushgateway.yml 

kubectl create -f deploy-mariadb-master.yml && kubectl create -f deploy-mariadb-slave.yml && kubectl create -f deploy-writer.yml && kubectl create -f deploy-reader.yml && kubectl create -f deploy-prometheus.yml && kubectl create -f deploy-grafana.yml && kubectl create -f deploy-pushgateway.yml


6. enable forward server each in separate terminal tab:

kubectl port-forward service/mariadb-master 3306:3306
kubectl port-forward service/mariadb-slave 3307:3306
kubectl port-forward service/reader-server 4444:4444
kubectl port-forward service/prometheus-server 9090:9090
kubectl port-forward service/grafana-server 3000:3000

7. Configure grafana:
connect prometheus
create two dashboards writer and reader


Additional commands for debug:

6a. delete:
kubectl delete -f configmap-mariadb-master.yml
kubectl delete -f configmap-prometheus.yml 

start deployments
kubectl delete -f deploy-mariadb-master.yml
kubectl delete -f deploy-mariadb-slave.yml
kubectl delete -f deploy-writer.yml
kubectl delete -f deploy-reader.yml
kubectl delete -f deploy-prometheus.yml 
kubectl delete -f deploy-grafana.yml 
kubectl delete -f deploy-pushgateway.yml 

start services
kubectl delete -f service-mariadb.yml
kubectl delete -f service-mariadb-slave.yml
kubectl delete -f service-reader.yml
kubectl delete -f service-prometheus.yml 


6b. get logs:
kubectl logs podname

echo test | nc 127.0.0.1 4444

###test commands:####
https://kublr.com/blog/setting-up-mysql-replication-clusters-in-kubernetes-2/


mysql -h mariadb-master -u root -pmasterqwerty test -e "INSERT INTO test.new_table (\`name\`, \`address\`) VALUES (\`ccc\`, \`bbb\`)"

-e "INSERT INTO test.new_table (name, address) VALUES (ccc, bbb)"

mysql -h mariadb-master -u root -pmasterqwerty -D test -e "INSERT INTO `new_table` (\`name\`, \`address\`) VALUES (\`ccc\`, \`bbb\`);" > output.txt 

mysql -h mariadb-master -u root -pmasterqwerty -D test -e "INSERT INTO new_table (name, address) VALUES (ccc, bbb);" > output.txt 

echo "INSERT INTO `new_table`(name, address) VALUES (\`aaa\`, \`bbb\`);" | mysql -h mariadb-master -u root -pmasterqwerty -D test
echo "UPDATE `database` SET `field1` = '1' WHERE `id` = 1111;" | mysql database --user='root' --password='my-password'


mysql -h mariadb-master -u root -pmasterqwerty -D test -e  "USE test; SELECT * FROM test.new_table;" | tee queryresults.txt

mysql -h mariadb-master -u root -pmasterqwerty -D test -e  "USE test; INSERT INTO test.new_table (name, address) VALUES ('aaa11', 'bbb'); "


INSERT INTO test.new_table (name, address) VALUES ("ggg", "ddd"); 


#bin/bash

docker run -dti -p 3806:3306 --name mariadb-master -e MARIADB_ROOT_PASSWORD=masterqwerty -e MARIADB_REPLICATION_MODE=master -e MARIADB_REPLICATION_USER=replicauser -e MARIADB_REPLICATION_PASSWORD=qwerty12 -e MARIADB_USER=replicauser -e MARIADB_PASSWORD=qwerty -e MARIADB_DATABASE=test  bitnami/mariadb:latest

docker run -dti -p 3807:3306 --name mariadb-slave --link mariadb-master:master -e MARIADB_REPLICATION_MODE=slave -e MARIADB_REPLICATION_USER=replicauser -e MARIADB_REPLICATION_PASSWORD=qwerty12 -e MARIADB_MASTER_HOST=master -e MARIADB_MASTER_ROOT_PASSWORD=masterqwerty bitnami/mariadb:latest

docker run -dti -p 3808:3306 --name mariadb-slave2 --link mariadb-master:master -e MARIADB_REPLICATION_MODE=slave -e MARIADB_REPLICATION_USER=replicauser -e MARIADB_REPLICATION_PASSWORD=qwerty12 -e MARIADB_MASTER_HOST=master -e MARIADB_MASTER_ROOT_PASSWORD=masterqwerty bitnami/mariadb:latest

docker run -dti -p 3809:3306 --name mariadb-slave3 --link mariadb-master:master -e MARIADB_REPLICATION_MODE=slave -e MARIADB_REPLICATION_USER=replicauser -e MARIADB_REPLICATION_PASSWORD=qwerty12 -e MARIADB_MASTER_HOST=master -e MARIADB_MASTER_ROOT_PASSWORD=masterqwerty bitnami/mariadb:latest
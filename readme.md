
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
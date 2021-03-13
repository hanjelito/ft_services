#!/bin/sh

# Colors.
GREEN='\033[1;32m'
BLUE='\033[0;34m'
END='\033[1;37m'

# Kill all processes.
minikube delete
#killall kubectl
killall -TERM kubectl minikube VBoxHeadless

# Start minikube.
minikube config unset vm-driver
minikube start --driver=virtualbox
kubectl proxy & > /dev/null
# Use the docker daemon from minikube.
#eval $(minikube -p minikube docker-env)

eval $(minikube docker-env)
# Build docker images.
# ""> /dev/null 2>&1" redirects the output of your program to /dev/null. Include both the Standard Error and Standard Out
# ">" is for redirect. "/dev/null" is a black hole where any data sent, will be discarded
# "2" is the file descriptor for Standard Error. "1" is the file descriptor for Standard Out.
# "&" is the symbol for file descriptor (without it, the following 1 would be considered a filename).
echo "${GREEN}Docker build init${END}"
docker build -t my_nginx ./srcs/nginx 2> error_nginx 1> /dev/null
kubectl apply -f srcs/nginx.yaml
#
docker build -t my_mysql ./srcs/mysql 2> error_mysql 1> /dev/null 
kubectl apply -f srcs/mysql.yaml
#
docker build -t my_phpmyadmin ./srcs/phpmyadmin 2> error_phpmyadmin 1> /dev/null
kubectl apply -f srcs/phpmyadmin.yaml
#
docker build -t my_wordpress ./srcs/wordpress 2> error_wordpress 1> /dev/null
kubectl apply -f srcs/wordpress.yaml
#
docker build -t my_influxdb ./srcs/influxdb 2> error_influxdb 1> /dev/null
kubectl apply -f srcs/influxdb.yaml
#
docker build -t my_grafana ./srcs/grafana 2> error_grafana 1> /dev/null
kubectl apply -f srcs/grafana.yaml
#
docker build -t my_ftps ./srcs/ftps 2> error_ftps 1> /dev/null
kubectl apply -f srcs/ftps.yaml
# docker build -t my_ftps srcs/ftps > /dev/null 2>&1
echo "${BLUE}Docker build completed${END}"

echo "${GREEN}Metallb${END}"

# Apply yaml resources.
echo "${GREEN}Deploy init${END}"
# kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
# kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
# kubectl apply -f 

minikube addons enable metallb
kubectl apply -f srcs/metalLB.yaml





echo "${BLUE}Deploy completed${END}"

# Setup metalLB secret.
# kubectl create secret generic -n metallb-system memberlist  --from-literal=secretkey="$(openssl rand -base64 128)"

# Enable addons.
minikube addons enable dashboard
minikube addons enable metrics-server

# Open dashboard.
minikube dashboard

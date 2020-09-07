minikube start --vm-driver=docker

MINIKUBE_IP="$(kubectl get node -o=custom-columns='DATA:status.addresses[0].address' | sed -n 2p)"
WORDPRESS_IP=172.17.0.7
METALLB_IP_RANGE=172.17.0.3-172.17.0.13
FTPS_IP=172.17.0.3



cp srcs/containers/wordpress/srcs/wordpress_model.sql srcs/containers/wordpress/srcs/wordpress.sql
sed -i "s/WORDPRESS_IP/$WORDPRESS_IP/g" srcs/containers/wordpress/srcs/wordpress.sql

cp srcs/deployment/metallb-config_model.yaml srcs/deployment/metallb-config.yaml
sed -i "s/METALLB_IP_RANGE/$METALLB_IP_RANGE/g" srcs/deployment/metallb-config.yaml

cp srcs/containers/telegraf/srcs/telegraf_model.conf srcs/containers/telegraf/srcs/telegraf.conf
sed -i "s/MINIKUBE_IP/$MINIKUBE_IP/g" srcs/containers/telegraf/srcs/telegraf.conf

cp srcs/containers/ftps/srcs/start_model.sh srcs/containers/ftps/srcs/start.sh
sed -i "s/FTPS_IP/$FTPS_IP/g" srcs/containers/ftps/srcs/start.sh



kubectl apply -f https://raw.githubusercontent.com/google/metallb/v0.8.1/manifests/metallb.yaml

eval $(minikube docker-env)

docker build -t my_nginx srcs/containers/nginx
docker build -t my_mysql srcs/containers/mysql
docker build -t my_wordpress srcs/containers/wordpress
docker build -t my_phpmyadmin srcs/containers/phpmyadmin
docker build -t my_influxdb srcs/containers/influxdb
docker build -t my_telegraf srcs/containers/telegraf
docker build -t my_grafana srcs/containers/grafana
docker build -t my_ftps srcs/containers/ftps

kubectl apply -k ./srcs/deployment

sleep 12 #wait 12 sec.

kubectl exec -i $(kubectl get pods | grep mysql | cut -d" " -f1) -- mysql -u root -e 'CREATE DATABASE wordpress;'
kubectl exec -i $(kubectl get pods | grep mysql | cut -d" " -f1) -- mysql wordpress -u root < "srcs/containers/wordpress/srcs/wordpress.sql"

rm -f srcs/containers/wordpress/srcs/wordpress.sql
rm -f srcs/deployment/metallb-config.yaml
rm -f srcs/containers/telegraf/srcs/telegraf.conf
rm -f srcs/containers/ftps/srcs/start.sh

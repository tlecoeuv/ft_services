minikube start --vm-driver=docker

MINIKUBE_IP="$(kubectl get node -o=custom-columns='DATA:status.addresses[0].address' | sed -n 2p)"
kubectl apply -f https://raw.githubusercontent.com/google/metallb/v0.8.1/manifests/metallb.yaml

eval $(minikube docker-env)

docker build -t my_nginx srcs/containers/nginx
docker build -t my_mysql srcs/containers/mysql
docker build -t my_wordpress srcs/containers/wordpress
docker build -t my_phpmyadmin srcs/containers/phpmyadmin
docker build -t my_influxdb srcs/containers/influxdb
docker build -t my_telegraf srcs/containers/telegraf
docker build -t my_grafana srcs/containers/grafana

kubectl apply -k ./srcs/deployment

kubectl exec -i $(kubectl get pods | grep mysql | cut -d" " -f1) -- mysql -u root -e 'CREATE DATABASE wordpress;'
 kubectl exec -i $(kubectl get pods | grep mysql | cut -d" " -f1) -- mysql wordpress -u root < "srcs/containers/wordpress/srcs/wordpress.sql"

eval $(minikube docker-env)
kubectl apply -f https://raw.githubusercontent.com/google/metallb/v0.8.1/manifests/metallb.yaml

docker build -t my_nginx srcs/containers/nginx
docker build -t my_mysql srcs/containers/mysql
docker build -t my_wordpress srcs/containers/wordpress
docker build -t my_phpmyadmin srcs/containers/phpmyadmin
docker build -t my_influxdb srcs/containers/influxdb
docker build -t my_telegraf srcs/containers/telegraf
docker build -t my_grafana srcs/containers/grafana

kubectl apply -k ./srcs/deployment
kubectl exec -i $(kubectl get pods | grep mysql | cut -d" " -f1) -- mysql -u root -e 'CREATE DATABASE wordpress;'

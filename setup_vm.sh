minikube start --vm-driver=docker
kubectl apply -f https://raw.githubusercontent.com/google/metallb/v0.8.1/manifests/metallb.yaml

eval $(minikube docker-env)

docker build -t my_nginx srcs/containers/nginx
docker build -t my_mysql srcs/containers/mysql
docker build -t my_wordpress srcs/containers/wordpress
docker build -t my_phpmyadmin srcs/containers/phpmyadmin

kubectl apply -k ./srcs/deployment
kubectl exec -i $(kubectl get pods | grep mysql | cut -d" " -f1) -- mysql -u root -e 'CREATE DATABASE wordpress;'

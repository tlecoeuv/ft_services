minikube start --vm-driver=docker

eval $(minikube docker-env)

docker build -t my_nginx srcs/nginx
docker build -t my_mysql srcs/mysql
docker build -t my_wordpress srcs/wordpress
docker build -t my_phpmyadmin srcs/phpmyadmin

kubectl apply -k ./srcs/

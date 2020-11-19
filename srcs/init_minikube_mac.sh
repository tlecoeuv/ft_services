#!/usr/bin/env bash

rm -rf ~/.minikube
mkdir -p /goinfre/${USER}/.minikube
ln -sf /goinfre/${USER}/.minikube ~/.minikube
minikube start --vm-driver=virtualbox
eval $(minikube docker-env)

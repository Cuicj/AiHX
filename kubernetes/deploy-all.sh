#!/bin/bash

# 创建命名空间
echo "Creating namespace..."
kubectl apply -f namespace.yaml

# 部署基础设施服务
echo "Deploying infrastructure services..."
kubectl apply -f mysql-init-configmap.yaml
kubectl apply -f infrastructure.yaml

# 等待基础设施服务启动
echo "Waiting for infrastructure services to start..."
sleep 30

# 部署Eureka Server
echo "Deploying Eureka Server..."
kubectl apply -f eureka-server.yaml

# 等待Eureka Server启动
echo "Waiting for Eureka Server to start..."
sleep 20

# 部署微服务
echo "Deploying microservices..."
kubectl apply -f user-auth-service.yaml
kubectl apply -f resource-service.yaml
kubectl apply -f chemistry-content-service.yaml
kubectl apply -f quiz-service.yaml
kubectl apply -f reward-service.yaml
kubectl apply -f learning-service.yaml

# 部署API Gateway
echo "Deploying API Gateway..."
kubectl apply -f api-gateway.yaml

# 查看部署状态
echo "Deployment completed. Checking status..."
kubectl get all -n cmatedata

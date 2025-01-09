# Deploying the project locally

## Needed env vars
- `DOCKER_TOKEN` - token for github registry

## Start Minikube
```shell
minikube start
minikube dashboard
```

## Create the rabbitmq cluster
```shell
kubectl apply -f "https://github.com/rabbitmq/cluster-operator/releases/latest/download/cluster-operator.yml"
kubectl apply -f "./.deploy/k8s/infra/rabbitmq/cluster.yaml"
kubectl apply -f "./.deploy/k8s/infra/rabbitmq/service.yaml"
minikube service judge-rabbitmq-exposer --url
```

## Deploy the queues and exchanges
```shell
cd .deploy/terraform/rabbitmq
export TF_VAR_rabbitmq_host=127.0.0.1
export TF_VAR_rabbitmq_port=#TODO - fill up depending on the actual port
export TF_VAR_rabbitmq_username=$(kubectl get secret judge-rabbitmq-default-user -o jsonpath="{.data.username}" | base64 --decode)
export TF_VAR_rabbitmq_password=$(kubectl get secret judge-rabbitmq-default-user -o jsonpath="{.data.password}" | base64 --decode)
terraform init
terraform plan
terraform apply
# stop the port forwarding terminal
```

## Setup postgres secrets
```shell
kubectl create secret generic postgres-secrets \
--from-literal=POSTGRES_USER="postgres" \
--from-literal=POSTGRES_PASSWORD="my-super-secret-password"
```

# Setup postgres
```shell
kubectl apply -f "./.deploy/k8s/infra/postgres/volume-claim.yaml"
kubectl apply -f "./.deploy/k8s/infra/postgres/deployment.yaml"
kubectl apply -f "./.deploy/k8s/infra/postgres/service.yaml"
```

## Allow image pulling from the github registry
```shell
kubectl create secret docker-registry regcred --docker-server=ghcr.io/yordaniliev2002 --docker-username=YordanIliev2002 --docker-password=${DOCKER_TOKEN} --docker-email=jordan.iliev501@gmail.com
```

## Deploy the workers
```shell
kubectl apply -f "./.deploy/k8s/apps/worker/deployment.yaml"
```

# Deploy the server
```shell
kubectl apply -f "./.deploy/k8s/apps/server/deployment.yaml"
kubectl apply -f "./.deploy/k8s/apps/server/service.yaml"
minikube service judge-server-exposer --url
```

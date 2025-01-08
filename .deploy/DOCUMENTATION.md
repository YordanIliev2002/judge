## Start Minikube
```shell
minikube start
minikube dashboard
```

## Create the rabbitmq cluster
```shell
kubectl apply -f "https://github.com/rabbitmq/cluster-operator/releases/latest/download/cluster-operator.yml"
kubectl apply -f "./.deploy/k8s/rabbitmq.yaml"
```

## Deploy the queues and exchanges
```shell
kubectl port-forward "service/judge-rabbitmq" 15672
cd .deploy/terraform/rabbitmq
terraform init
export TF_VAR_rabbitmq_host=127.0.0.1
export TF_VAR_rabbitmq_username=$(kubectl get secret judge-rabbitmq-default-user -o jsonpath="{.data.username}" | base64 --decode)
export TF_VAR_rabbitmq_password=$(kubectl get secret judge-rabbitmq-default-user -o jsonpath="{.data.password}" | base64 --decode)
terraform plan
terraform apply
```


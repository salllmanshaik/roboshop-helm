#URL=$(kubectl get svc argocd-server -n argocd | grep argocd | awk '{print $4}')

component_name=$1
env=$2
imageTag=$3

kubectl create ns app || true

PASSWORD=$(kubectl get secrets -n argocd argocd-initial-admin-secret -o json | jq .data.password|xargs | base64 --decode)

argocd login argocd-${env}.salman06.shop --grpc-web --insecure --username admin --password $PASSWORD



argocd app create ${component_name} --upsert --repo https://github.com/salllmanshaik/roboshop-helm --path . --dest-namespace app --dest-server https://kubernetes.default.svc --values env-${env}/${component_name}.yaml --helm-set imageTag=${imageTag}

argocd app sync ${component_name}

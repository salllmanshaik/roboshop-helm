URL=$(kubectl get svc argocd-server -n argocd | grep argocd | awk '{print $4}')

PASSWORD=$(kubectl get secrets -n argocd argocd-initial-admin-secrets -o json | jq .data.password|xargs base64 --decode)

argocd login $URL --grcp-web --insecure --username admin --password $PASSWORD

component_name=$1
env=$2
imageTag=$3

argocd app create ${component_name} --upsert --repo https://github.com/salllmanshaik/roboshop-helm --path . --dest-namespace default --dest-server https://kubernetes.default.svc --values env-${env}/${component_name}.yaml --helm-set imaggeTag=${imageTag}

argocd app sync ${component_name}
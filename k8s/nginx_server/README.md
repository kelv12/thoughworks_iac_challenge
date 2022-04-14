# Setup nginx
## Authentication to GKE.

Set variables:

```shell
# Get the relevant value from `terraform output` command inside projects/serviceprojects.
PROJ_ID=<dev_project_id/prod_project_id>

# Get the value from `terraform output` command inside resources/<project folder>
BASTION_HOST=<bastion_hostname>

# Get the value from `terraform output` command inside resources/<project folder>
GKE_CLUSTER_NAME=<gke_name>

# Get the value from `terraform output` command inside resources/<project folder>
GKE_CLUSTER_LOCATION=<gke_location>

# Run following command to get the cluster endpoint. Endpoint is set as a sensitive output in terraform, so have to use gcloud to get the output.
# `gcloud container clusters describe yassir --project $PROJ_ID --region $GKE_CLUSTER_LOCATION|grep privateEndpoint`

# set the value of above command here.
GKE_ENDPOINT=192.168.0.2
```

### Connect to GKE via bastion host

Connect to bastion host:

```shell
gcloud compute ssh $BASTION_HOST --project $PROJ_ID
```

Get credentials. Run the following command from bastion host:
For following command to work, above variables need to be updated in bastion host as well:

```shell
gcloud container clusters get-credentials $GKE_CLUSTER_NAME --zone $GKE_CLUSTER_LOCATION --project $PROJ_ID
```

Now kubectl commands can be executed.

### Connect to GKE via local shell and port-forward

Port forward via bastion:
```shell
gcloud compute ssh $BASTION_HOST --project $PROJ_ID --tunnel-through-iap --ssh-flag="-L 8443:$GKE_ENDPOINT:443"
```

In a new terminal, get kubeconfig credentials. For the following commands to work,
the variables above need to be exported again:

```shell
KUBECONFIG=./kubeconfig.yaml gcloud container clusters get-credentials $GKE_CLUSTER_NAME --zone $GKE_CLUSTER_LOCATION --project $PROJ_ID
```

Replace endpoint with https://kubernetes.default:8443 (use 'gsed' on mac):

```shell
sed -i 's/server:.*$/server\:\ https\:\/\/kubernetes.default\:8443/g' ./kubeconfig.yaml
```

Add a host entry in the local machine:

```shell
sudo echo '127.0.0.1 kubernetes kubernetes.default' >> /etc/hosts
```

Now kubectl commands can be executed.
For a custom configuration, the following command can be used:

```shell
KUBECONFIG=./kubeconfig.yaml kubectl get pods
```
## Deploy nginx

Set variables.

```shell
# Get the value from `terraform output` command inside resources/app_dev_project.
INSTANCE_NAME=<master_instance_name>

# Get the value from `terraform output` command inside resources/app_dev_project.
INSTANCE_CONN_NAME=<instance_connection_name> 

# Get the relevant value from `terraform output` command inside projects/serviceprojects.
PROJ_ID=<dev_project_id/prod_project_id>

# Use the same value passed for knamespace in resources/dev_project/terraform.tfvars
NAMESPACE=wils

# Pass required username.
SQL_UNAME=nginx

# Pass required password.
SQL_PASS=test
```

Create namespace:

```shell
kubectl create namespace $NAMESPACE
```

Correct the service account name in `k8s/examples/ksa.yml`:
```shell
sed -i 's/CHANGEME/'"$PROJ_ID"'/g' ksa.yml
```

Install Kubernetes Service Account:

```shell
kubectl apply -f ksa.yml  -n $NAMESPACE
```

Make sure the sql instance is running.
Create database and user. This can be done in terraform as well.

```shell
gcloud sql databases create nginx --instance $INSTANCE_NAME --project $PROJ_ID
gcloud sql users create $SQL_UNAME --host=% --instance $INSTANCE_NAME --password $SQL_PASS --project $PROJ_ID
```

Create kubernetes secret using the previously created credentials:
```shell
kubectl create secret generic cloudsql-db-credentials --from-literal username=$SQL_UNAME --from-literal password=$SQL_PASS -n $NAMESPACE
```

Change instance connection name in `k8s/examples/deployment.yml` (use 'gsed' on mac):
```shell
sed -i 's/CHANGEME/'"$INSTANCE_CONN_NAME"'/g' deployment.yml
```

Deploy the k8s deployment:
```shell
kubectl apply -f deployment.yml -n $NAMESPACE
```

Create service:
```shell
kubectl apply -f service.yml -n $NAMESPACE
```

Get the external ip with following command:
```shell
kubectl get svc -n $NAMESPACE
NAME        TYPE           CLUSTER-IP   EXTERNAL-IP     PORT(S)        AGE
nginx   LoadBalancer   10.2.83.56   34.159.69.215   80:32131/TCP   4m45s
```

Go into your browser to test the connection.

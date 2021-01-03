 # Before to start 
 Install AWS cli, terraform, kubectl, aws-iam-authenticator, docker
 
```shell
$ aws configure
AWS Access Key ID [None]: <YOUR_AWS_ACCESS_KEY_ID>
AWS Secret Access Key [None]: <YOUR_AWS_SECRET_ACCESS_KEY>
Default region name [None]: <YOUR_AWS_REGION>
Default output format [None]: json
``` 
# Build and publish flask docker image to ECR
go to directory API
make scripts executable chmod +x
1 run build.sh script
2 run publish.sh script
 
 # Terraform - Provision an EKS Cluster

go to root directory of this repo and perform command

```shell
$ terraform init

```

Then, provision your EKS cluster by running `terraform apply`. This will 
take approximately 10 minutes.

```shell
$ terraform apply

# Output truncated...

Plan: 51 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

# Output truncated...

Apply complete! Resources: 51 added, 0 changed, 0 destroyed.

Outputs:

cluster_endpoint = https://A1ADBDD0AE833267869C6ED0476D6B41.gr7.us-east-2.eks.amazonaws.com
cluster_security_group_id = sg-084ecbab456328732
kubectl_config = apiVersion: v1
preferences: {}
kind: Config

clusters:
- cluster:
    server: https://A1ADBDD0AE833267869C6ED0476D6B41.gr7.us-east-2.eks.amazonaws.com
    certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUN5RENDQWJDZ0F3SUJBZ0lCQURBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwcmRXSmwKY201bGRHVnpNQjRYRFRJd01ETXdPVEU0TXpVeU1sb1hEVE13TURNd056RTRNelV5TWxvd0ZURVRNQkVHQTFVRQpBeE1LYTNWaVpYSnVaWFJsY3pDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBTThkClZaN1lmbjZmWm41MEgwL0d1Qi9lRmVud2dydXQxQlJWd29nL1JXdFpNdkZaeStES0FlaG5lYnR5eHJ2VVZWMXkKTXVxelBiMzgwR3Vla3BTVnNTcDJVR0ptZ2N5UVBWVi9VYVZDQUpDaDZNYmIvL3U1bWFMUmVOZTBnb3VuMWlLbgpoalJBYlBJM2JvLzFPaGFuSXV1ejF4bmpDYVBvWlE1U2N5MklwNnlGZTlNbHZYQmJ6VGpESzdtK2VST2VpZUJWCjJQMGd0QXJ3alV1N2MrSmp6OVdvcGxCcTlHZ1RuNkRqT1laRHVHSHFRNEpDUnRsRjZBQXpTUVZ0cy9aRXBnMncKb2NHakd5ZE9pSmpMb1NsYU9weDIrMTNMbHcxMDAvNmY4Q0F2ajRIbFZUZDBQOW5rN1UyK04xNSt5VjRpNjFoQgp3bHl4SXFUWEhDR0JvYmRNNE5VQ0F3RUFBYU1qTUNFd0RnWURWUjBQQVFIL0JBUURBZ0trTUE4R0ExVWRFd0VCCi93UUZNQU1CQWY4d0RRWUpLb1pJaHZjTkFRRUxCUUFEZ2dFQkFIbEI3bGVMTnJYRXZnNksvNUdtR2s5Tlh4SUkKRDd0Y1dkTklBdnFka1hWK3ltVkxpTXV2ZGpQVjVKV3pBbEozTWJqYjhjcmlQWWxnVk1JNFJwc0N0aGJnajMzMwpVWTNESnNxSmZPUUZkUnkvUTlBbHRTQlBqQldwbEtaZGc2dklxS0R0eHB5bHovOE1BZ1RldjJ6Zm9SdzE4ZnhCCkI2QnNUSktxVGZCNCtyZytVcS9ULzBVS1VXS0R5K2gyUFVPTEY2dFVZSXhXM2RncWh0YWV3MGJnQmZyV3ZvSW8KYitSOVFDTk42UHRQNEFFQSsyQnJYYzhFTmd1M2EvNG9rN3lPMjZhTGJLdC9sbUNoNWVBOEdBRGJycHlWb3ZjVgpuTGdyb0FvRnVRMCtzYjNCTThUcEtxK0YwZ2dwSFptL3ZFNjh5NUk1VFlmUUdHeEZ6VEVyOHR5NHk1az0KLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo=
  name: eks_training-eks-TNajBRIF

contexts:
- context:
    cluster: eks_training-eks-TNajBRIF
    user: eks_training-eks-TNajBRIF
  name: eks_training-eks-TNajBRIF

current-context: eks_training-eks-TNajBRIF

users:
- name: eks_training-eks-TNajBRIF
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "training-eks-TNajBRIF"



region = us-east-1
```

## Configure kubectl

To configure kubetcl, you need both [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) and [AWS IAM Authenticator](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html).

The following command will get the access credentials for your cluster and automatically
configure `kubectl`.

```shell
$ aws eks --region $(terraform output region) update-kubeconfig --name $(terraform output cluster_name)
```

The
[Kubernetes cluster name](https://github.com/hashicorp/learn-terraform-eks/blob/master/outputs.tf#L26)
and [region](https://github.com/hashicorp/learn-terraform-eks/blob/master/outputs.tf#L21)
 correspond to the output variables showed after the successful Terraform run.

You can view these outputs again by running:

```shell
$ terraform output
```
# Deploy the NGINX Ingress Controller for Kubernetes

1.    To download the NGINX Ingress Controller for Kubernetes, run the following command:
```
git clone https://github.com/nginxinc/kubernetes-ingress.git
```
2.    To choose the directory for deploying the Ingress Controller, run the following command:
```
cd kubernetes-ingress/deployments/
```
To create a dedicated namespace, service account, and TLS certificates (with a key) for the default server, run the following commands:
```
kubectl apply -f common/ns-and-sa.yaml
kubectl apply -f common/default-server-secret.yaml
```
4.    To create a ConfigMap for customizing your NGINX configuration, run the following command:
```
kubectl apply -f common/nginx-config.yaml
```
5.    To configure role-based access control (RBAC), create a ClusterRole, and then bind the ClusterRole to the service account from step 3. For example:
```
kubectl apply -f rbac/rbac.yaml
```
6.    To deploy the Ingress Controller, run the following commands.
```
kubectl apply -f deployment/nginx-ingress.yaml
kubectl get pods --namespace=nginx-ingress
```
You receive output similar to the following:
```
NAME                            READY   STATUS    RESTARTS   AGE
nginx-ingress-fb4f4b44c-xmq6z   1/1     Running   0          3d7h
```
# Access the Ingress Controller and run your application
1.  To apply your configuration, run the following commands:
```
kubectl apply -f service/loadbalancer-aws-elb.yaml
```
```
kubectl get svc --namespace=nginx-ingress
```
You receive output similar to the following:

```
NAME          TYPE         EXTERNAL-IP                                      PORT(S)
nginx-ingress LoadBalancer aaa71bxxxxx-11xxxxx10.us-east-1.elb.amazonaws.com 80:32462/TCP,443:32226/TCP
```
2.    To configure NGINX to use the PROXY protocol so that you can pass proxy information to the Ingress Controller, add the following keys to the nginx-config.yaml file from step 1. For example:
```
kind: ConfigMap
apiVersion: v1
metadata:
  name: nginx-config
  namespace: nginx-ingress
data:
  proxy-protocol: "True"
  real-ip-header: "proxy_protocol"
  set-real-ip-from: "0.0.0.0/0"
```
3.    To update the ConfigMap, run the following command:
```
kubectl apply -f common/nginx-config.yaml
```
4. To apply flask deployment and service go to root directory of this repo and perform:
```
kubectl apply -f flask.yaml
```
5 Implement Ingress so that it interfaces with your services using a single load balancer provided by Ingress Controller. Use  micro-ingress.yaml file
```
kubectl apply -f micro-ingress.yaml
```

## Requirements
1. Dashboard License
3. Terraform
4. K8s cluster

## Instructions
1. Create namespace
```
kubectl create namespace tyk-dp
```

2. Create secret
```
kubectl create secret generic tyk-secret --namespace tyk-dp \
   --from-literal=orgId=6673bba6409fbc0001f2b0df \
   --from-literal=userApiKey=9527818cc55f46a05f091769141b0d20 \
   --from-literal=groupID=tyk-dp \
   --from-literal=APISecret=topsecretpassword
```

3. Run Terraform install
```
terraform init
terraform apply --var namespace=tyk-dp --var cp_mdcb_connection_string=mdcb-svc-tyk-tyk-mdcb.tyk.svc:9091 --var cp_mdcb_use_ssl=false
```

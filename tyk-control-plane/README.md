## Requirements
1. Dashboard License
2. MDCB License
3. Terraform
4. K8s cluster

## Instructions
1. Create namespace
```
kubectl create namespace tyk
```

2. Create secret
```
kubectl create secret generic tyk-secret --namespace tyk \
   --from-literal=AdminSecret=12345 \
   --from-literal=APISecret=topsecretpassword \
   --from-literal=DashLicense= \
   --from-literal=MDCBLicense= \
   --from-literal=adminUserFirstName=Default \
   --from-literal=adminUserLastName=Example \
   --from-literal=adminUserEmail=default@example.com \
   --from-literal=adminUserPassword=topsecretpassword
```

3. Run Terraform install
```
terraform init
terraform apply
```
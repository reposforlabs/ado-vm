resourcegroup="RG-VM"
location="westus3"
vmname="VM1"
username="azureuser"
userpassword='123456789aa#'

az group create --name $resourcegroup --location $location

az vm create --resource-group $resourcegroup `
--name $vmname `
--image Win2022AzureEditionCore `
--size Standard_DS2_v2 `
--public-ip-sku Standard `
--admin-username $username `
--admin-password $userpassword

az vm run-command invoke -g $resourcegroup `
-n $vmname `
--command-id RunPowerShellScript `
--scripts "Install-WindowsFeature -name Web-Server -IncludeManagementTools"

az vm open-port --port 80 `
--resource-group $resourcegroup `
--name $vmname

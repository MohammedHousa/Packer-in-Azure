# Install Azure CLI on Windows https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-windows?tabs=azure-cli
# Install Packer https://www.packer.io/downloads
# Create a resource group 
az group create -n myResourceGroup -l eastus 

# Create a service principal 
az ad sp create-for-rbac --query "{ client_id: appId, client_secret: password, tenant_id: tenant }" 

# Obtain your Azure subscription ID
az account show --query "{ subscription_id: id }"

# Build the image
packer build ubuntu.json

# Create VM from Azure Image
az vm create --resource-group myResourceGroup --name myVM --image myPackerImage --admin-username azureuser --generate-ssh-keys

# Open port 80
az vm open-port --resource-group myResourceGroup --name myVM --port 80

# aks-infra

- Deploys two Azure Kubernetes Service clusters in the westus2 region and the westeurope region
- Uses a single Azure Managed Identity
- Each cluster sits in it's own /24 subnet and uses kubenet for networking 
- Requires users to be in the correct Azure Active Directory group to perform any kubectl commands

var var_vnetName = 'biceptestcluster-vnet'
var var_subnetName = 'biceptestcluster-subnet'

module vnet './vnet.bicep' = {
  name: 'vnet'
  params: {
    vnetName: var_vnetName
    subnetName: var_subnetName
  }
}

module aksCluster './akscluster.bicep' = {
  name: 'aks'
  dependsOn: [
    vnet
  ]
  params: {
    vnetName: var_vnetName
    subnetName: var_subnetName
  }
}

output subnetId string = vnet.outputs.subnetId
output aksServerFqdn string = aksCluster.outputs.clusterFqdn

param vnetName string = 'biceptestcluster-vnet'
param subnetName string = 'biceptestcluster-subnet'
param location string = resourceGroup().location

resource bicepVirtualNetwork 'Microsoft.Network/virtualNetworks@2021-02-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '100.64.0.0/10'
      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: '100.64.0.0/24'
        }
      }
    ]
  }
}

output subnetId string = bicepVirtualNetwork.properties.subnets[0].id
output vnetName string = bicepVirtualNetwork.name

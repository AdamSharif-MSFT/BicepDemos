param vnetName string
param subnetName string
param location string = resourceGroup().location

resource bicepAksCluster 'Microsoft.ContainerService/managedClusters@2021-03-01' = {
  name: 'biceptestcluster'
  location: location
  properties: {
    kubernetesVersion: '1.19.9'
    dnsPrefix: 'aks${uniqueString(resourceGroup().id)}'
    networkProfile: {
      networkMode: 'transparent'
      networkPlugin: 'azure'
      loadBalancerSku: 'standard'
      serviceCidr: '192.168.25.0/24'
      dockerBridgeCidr: '172.17.0.1/24'
      dnsServiceIP: '192.168.25.10'
      loadBalancerProfile: {
        allocatedOutboundPorts: 1000
        managedOutboundIPs: {
          count: 1
        }
      }
      networkPolicy: 'azure'
      outboundType: 'loadBalancer'
    }
    nodeResourceGroup: 'aks-biceptestcluster-res'
    agentPoolProfiles: [
      {
        name: 'agentpool1'
        count: 1
        vmSize: 'Standard_B2ms'
        osDiskSizeGB: 30
        vnetSubnetID: resourceId('Microsoft.Network/virtualNetworks/subnets', vnetName, subnetName)
        mode: 'System'
      }
    ]
    servicePrincipalProfile: {
      clientId: 'eee5a531-def1-4ffe-bab9-5d684a431882'
      secret: 'dUJF_~RS4kuw5~_KM._6FEi9B_uOkKQ0cL'
    }
  }
}

output clusterFqdn string = bicepAksCluster.properties.fqdn

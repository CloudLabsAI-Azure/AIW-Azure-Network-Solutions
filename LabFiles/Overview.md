### Azure Networking Solutions

### Overview


### Hands-on Labs Scenario

Contoso Insurance Company has been in business for over 20 years and is a well-known and respected name brand in the Insurance industry. They are historically risk-averse, and it has served them well, enabling them to weather several financial storms that closed the doors on similarly sized institutions. While Contoso started in Miami United States, around 20 years ago, they have started their new branch in Florida city around 10 years ago. 

Contoso Insurance has placed both offices in different networks and connected the networks to each other using VNet peering to communicate between the branches and access the resources vice-versa. Also, they have set up an availability set on their headquarter servers to give 100 percent availability to their Users. They have set up a Load Balancer to maintain the load between the servers and switch whenever required. 

Contoso Insurance Company has set up the application gateway to connect with the Servers because of safety concerns and they have set up an Azure Firewall with Firewall policy on the application gateway to keep the servers safe from attackers.

### Lab Context

In this workshop, you will learn how to setup and configure a virtual network with subnets in Azure. You will deploy a pre-configured IaaS environment then redesign and update it to account for high availability with the help of Azure Load balancer. You will provision Virtual Network in secondary region and deploy a virtual machine within the Vnet. You'll also configure Peering connections between the Vnets and test inter-site virtual machine connectivity on your private network.

You will learn how to enhance the security of your application with the help of Azure application gateway (WAF) and Azure Firewall. You will configure User defined route(UDR) and outbound traffic to go via Azure Firewall. You will enable Network Watcher and utilize tools to monitor, troubleshoot, view metrics, and enable logs for resources in your Azure virtual network.


### Solution Architecture

 ![pip](https://github.com/CloudLabsAI-Azure/AIW-Azure-Network-Solutions/blob/main/media/Picture10.png?raw=true)
 

## Exercise 1: Getting Started with Azure 

In this exercise, you will log in to the Azure Portal and review the pre-deployed resources as part of the lab environment.

## Exercise 2: Provision Network Landing Zone

In this exercise, you'll create a Virtual Network and subnets for different scenarios like AVD, DMZ, Internal, and AzureFirewallSubnet.

## Exercise 3: Provision Sample Application in Existing Network

In this exercise, you will create the virtual machines and place them in the backend pool of the load balancer. By doing so, you will be able to check the load balancing between virtual machines. You will also test the behavior of the load balancer in case of VM failover.

## Exercise 4:  Provision Secondary Azure Region Infrastructure 

In this exercise, you'll create a Virtual Network in Region-2 and deploy a VM within the Vnet. You'll also configure Peering connections between the Vnets and test inter-VM connectivity on your private network

## Exercise 5: Provision & Configure Azure Firewall & Application Gateway

In this exercise, you will deploy a Firewall and Application Gateway with WAF then you will publish an application through them. You'll also test the application for security and perform a sample attack, and also you'll configure UDR and outbound traffic to go via Azure Firewall.

## Exercise 6: Monitoring Azure Network

In this exercise, you will enable a Network Watcher and create Flow Logs to run Sample traffic and perform Sample network troubleshooting. You'll also deploy Log Analytics Workspace and Network Monitoring Solution to set up Azure Monitor Alerts and test notifications.

# Release Notes

### 12 July 2022

### Azure-Network-Solutions

In this lab, you will learn how to setup and configure a virtual network with subnets in Azure. You will deploy a pre-configured IaaS environment then redesign and update it to account for high availability with the help of Azure Load balancer. You will provision Virtual Network in a secondary region and deploy a virtual machine within the Vnet. You'll also configure Peering connections between the Virtual Networks and test inter-site Virtual Machine connectivity on your private network.

You will learn how to enhance the security of your application with the help of Azure application gateway (WAF) and Azure Firewall. You will configure User-defined route (UDR) and outbound traffic to go via Azure Firewall. You will enable Network Watcher and utilize tools to monitor, troubleshoot, view metrics, and enable logs for resources in your Azure virtual network.

This lab includes the following exercises:

### Exercise 1: Getting Started with Azure 

In this exercise, you will log in to the Azure Portal and review the pre-deployed resource groups that are deployed as part of the lab environment.

### Exercise 2: Provision Network Landing Zone

In this exercise, you'll create a Virtual Network and subnets for different scenarios like AVD, DMZ, Internal, and AzureFirewallSubnet.

### Exercise 3: Provision Contoso Insurance Application in Existing Network

In this exercise, you will deploy a Virtual Machine using a pre-built ARM template, create a Public IP address and associate it to the Virtual Machine. Then you'll create a network security group, add rules to allow outbound traffic, and associate it with the virtual machine's network interface. You will then test the Contoso Insurance application.

### Exercise 4:  Setup Load Balancing 

In this exercise, you will provision a secondary Virtual Machine with the Contoso Insurance application hosted on it. You will deploy an external Load Balancer, place Virtual Machines in the backend pool and check the load balancing between virtual machines. You will also test the behavior of the load balancer in case of VM failover.

### Exercise 5: Provision & Configure Azure Firewall & Application Gateway

In this exercise, you will deploy a Firewall and Application Gateway with WAF then you will publish an application through them. You'll also test the application for security and perform a sample attack, and also you'll configure UDR and outbound traffic to go via Azure Firewall.

### Exercise 6: Provision Secondary Azure Region Infrastructure

In this exercise, you'll create a Virtual Network in a secondary region and deploy a VM within the Vnet. You'll also configure Peering connections between the Vnets and test inter-VM connectivity on your private network.

### Exercise 7: Monitoring Azure Network

In this exercise, you will enable a Network Watcher and create Flow Logs to run Sample traffic and perform Sample network troubleshooting. You'll also deploy Log Analytics Workspace and Network Monitoring Solution to set up Azure Monitor Alerts and test notifications.

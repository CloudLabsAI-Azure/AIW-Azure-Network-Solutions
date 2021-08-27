# Exercise 3: Provision Sample Application in Existing Network

Duration: 60-70 mins

## Overview

In this exercise, you will create a primary and secondary virtual machine along with load balancer to check the LB & VM failover.

This exercise includes the following tasks:

*	Deploy VM using pre-built ARM Template in existing network. 

*	Add Public IP to the virtual machine 

*	Configure NSGs/ASGs and allow Application Access

*	Test Application 

*	Setup Load Balancing :

       *	 Provision Secondary VM.
       
       *	 Provision Load Balancing using External Load Balancer. 
       
       *	 Test LB & VM failover.


## Task 2: Add Public IP to the virtual machine

### Overview

In this task, you will associate the IP Address to Virtual Machine


1. Go to the cretaed VM and you can observer the Public IP is not associated.

   ![noIP](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/NoIp-VM1.png?raw=true)
   
2. From your **LABVM**, select **+ Create a resource**.

     ![Create resource](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/createRS.png?raw=true)
     
3. Search for **Public IP Address** and Click on **Create**

    ![create Vnet](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/createPIP-1.png?raw=true)
    
4. Enter the following information to create Public IP Address:

   - **SKU**  : **Standard**

   - **Tier** : **Regional**

   - **Name** : **PublicIP1-<inject key="DeploymentID" enableCopy="false"/>**

   - Choose your **Subscription Group**

   - **Resource Group** : **hands-on-lab-<inject key="DeploymentID" enableCopy="false"/>**

   - Click on **Create**.

   ![createIP](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/createPIP1.png?raw=true)

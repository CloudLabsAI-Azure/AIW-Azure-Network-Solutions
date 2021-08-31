 ## Exercise-4 : 	Provision Secondary Azure Region Infrastructure 
 
 Duration: 20-30 mins
 
 ## Overview
 
 In this task you'll establish a VNet in Region-2 (West US) and deploy a VM within it . You'll also configure Vnet Peering in the next step to test inter-VM connectivity on your private network.
 
 This exercise includes the following tasks:
 
* 	Provision Virtual Network – 2 (Region-2)

*	Provision Sample VM in VNET-2

*	Configure VNET Peering

*	Validate Inter VM Connectivity on private network. 


## Task-1 : Provision Virtual Network – 2 (Region-2)

### Overview

In this task, you will be creating a virtual network in Region-2 (West US)

1. Select **Show portal menu** from the upper left corner of the Azure Portal's **Home** page and then **Create a resource**.

    ![Create resource](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/createresou.png?raw=true)
    
2. In the **Search the Marketplace box**, select **Networking**, then **Virtual Network**, and finally Create.

      ![Create Resource](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/netvnet.png?raw=true)
      
3. On the **Basic** tab of **Create Virtual Network** blade, enter the following information and select **Review + Create**.

     - Subscription: Select your subscription.

     - Resource group: **hands-on-lab-<inject key="DeploymentID" enableCopy="false"/>**

     - Name: **NSVnet1-<inject key="DeploymentID" enableCopy="true"/>**

     - Location: **West US**

       ![second Vnet](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/2vnet.png?raw=true)
       
4. Review the configuration and select **Create**.

     ![create vnet](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/createVnet2.png?raw=true)
     
5. Wait for the confirmation that the Vnet has been successfully created. Once the virtual network has been successfully created, you can see the screen as seen in the screenshot below.

     1[go to resource](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/createvnet2.1.png?raw=true)

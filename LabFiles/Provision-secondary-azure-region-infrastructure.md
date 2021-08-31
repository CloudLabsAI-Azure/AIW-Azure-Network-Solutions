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

     ![go to resource](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/createvnet2.1.png?raw=true)


## Task-1 : 	Provision Sample VM in VNET-2

### Overview 

In this task you will be creating Sample VM in virtual network which was created in Region-2.

1. Now, navigate back to the **Home** page of Azure Portal and click on **Create a resource**.

     ![Create resource](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/createresou.png?raw=true)
     
2. Search for **Virtual machine** and click on **Create**

     ![create vm](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/createVM.png?raw=true)
     
3. Provide the below mentioned instructions for creating Virtual Machine under the **Basics** tab of **Create a virtual machine**.

     1 Resource Group : Select **hands-on-lab-<inject key="DeploymentID" enableCopy="false"/>** from drop down list.
     
     2 Region : **West US**
     
     3 Image : **Windows server 2019 Datacenter-Gen2
     
     4 Username : **demouser**
     
     5 Password : **Password.1!!**
     
     6 Confirm Password : **Password.1!!**
     
     7 Select **Next : Disks**
     
      ![create vm](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/createVM1.png?raw=true)
      
4. Leave everything as **Default** under **Disks** tab and move to **Networking**

5. Under **Networking** tab select **Virtual Network** as **NSVnet1-<inject key="DeploymentID" enableCopy="false"/>** from drop down list and select **Review + Create**.

     ![Review and create](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/reviewcre.png?raw=true)
     
6. Review the configuration and select **Create**

     ![create](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/createSamplevm.png?raw=true)

7. Wait until the Virtual Machine has been created successfully and select **Go to Resource**

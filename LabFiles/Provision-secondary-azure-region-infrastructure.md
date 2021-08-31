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
     
     2. Name : **SampleVM-<inject key="DeploymentID" enableCopy="true"/>**
     
     3 Region : **West US**
     
     4 Image : **Windows server 2019 Datacenter-Gen2
     
     5 Username : **demouser**
     
     6 Password : **Password.1!!**
     
     7 Confirm Password : **Password.1!!**
     
     8 Select **Next : Disks**
     
      ![create vm](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/createVM1.png?raw=true)
      
4. Leave everything as **Default** under **Disks** tab and move to **Networking**

5. Under **Networking** tab select **Virtual Network** as **NSVnet1-<inject key="DeploymentID" enableCopy="false"/>** from drop down list and select **Review + Create**.

     ![Review and create](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/reviewcre.png?raw=true)
     
6. Review the configuration and select **Create**

     ![create](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/createSamplevm.png?raw=true)

7. Wait until the Virtual Machine has been created successfully and select **Go to Resource**

     ![goto](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/sampleVMgoto.png?raw=true)


## Task-3 : Configure VNET Peering

### Overview

In this task you will be creating Peering for the Vnet.

1. From the **Overview** tab of **SampleVM-<inject key="DeploymentID" enableCopy="false"/>**, select **Virtual network**

     ![select vnet](![image](https://user-images.githubusercontent.com/83349577/131581610-832f3bc9-8ade-41e7-ba32-c164739b055b.png)
   
2. Select **Peerings** under Settings on the left and select **Add**.

     1[peering](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/peering.png?raw=true)
     
3. Set the following configuration for the new peering. Select Add to create the peering.

    - Peering link name (This virtual network): VNETPeering_NSVnet1-NSVnet

    - Traffic to remote virtual network: Allow (default)

    - Traffic forwarded from remote virtual network: Allow (default)

    - Peering link name (Remote virtual network: VNETPeering_NSVnet-NSVnet1

    - Virtual Network: WGVNet2

    - Traffic to remote virtual network: Allow (default)

    - Traffic forwarded from remote virtual network: Allow (default)

       ![peering](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/peering1.png?raw=true)



## Task-4 : Validate Inter VM Connectivity on private network. 

1. Now go back to the **Home** page of Azure Portal and select **Resource Group**

     ![reosurce group](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/resourcegroup.png?raw=true)
     
2. Select **hands-on-lab-<inject key="DeploymentID" enableCopy="false"/>**, then select **SampleVM-<inject key="DeploymentID" enableCopy="false"/>** from **Overview** tab of resource group.

   ![sample vm](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/selectsmaplevm.png?raw=true)
   
3. From the **Overview** of SampleVM-<inject key="DeploymentID" enableCopy="false"/>, select **Connect** to connect the VM to **RDP**

     ![vmto rdp](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/connectsamplevm.png?raw=true)
     
4. Select **Download RDP File** to download the RDP file, and then open it once it has been downloaded.

     ![rdp](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/download%20rdp.png?raw=true)
     
5. When you are prompted with Remote Desktop Connection box, select **Connect**

     ![connect](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/connect.png?raw=true)
     
6. To login into the Virtual Machine use these credentials:

     - Username: **demouser**

     - Password : **Password.1!!**

7. If you are asked with a dialogue box after entering your credentials, select **Yes**.

8. Now, from your Azure Portal navigate to **VM2-<inject key="DeploymentID" enableCopy="false"/>** and copy the **Private Ip address** from **Overview** tab.

     ![privateip](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/privateIp.png?raw=true)
     
9. Now, in the virtual machine that is connected to RDP, look for the **Remote desktop app** and double-click on it to open.

     ![rdp](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/rdpconnection.png?raw=true)
 
10. Now, provide the **Private IP address** that you copied in the step-8 and try to connect to **Remote Desktop App**

     ![private](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/connecprivate.png?raw=true)
     
11. Use the same credentials as in step 6 to connect to the Remote Desktop App.

12. If you can connect to the VM using a private IP address, you've successfully set up inter-VM connectivity on your private network.

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
   
5. Monitor the deployment status by selecting Notifications Bell at the top of the portal. In a minute or so, you should see a confirmation of the successful deployment. Select Go    to Resource.

  ![Create IP](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/GO-to-resource-pip1.png?raw=true)

6. To Associate the Public IP to VM follow the below instructions:

   - Click on **Associate**

7. Under the Associate Public IP address use the following instructions:

   - **Resource Type** : Select **Network Interface** from drop down.

   - **Network Interface** : Select Network Interface of the VM.

   - Click on **OK**

   ![AssociatePIP](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/asociate-PIP1.png?raw=true)
   
8. Now go back to the Virtual Machine and you can observe the Public Ip in Overview.

   ![PIP](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/changed%20Public%20IP%20in%20VM1.png?raw=true)
   
9. On Virtual Machine blade, under **Settings** Select **Networking** followed by **Add Inbound Port Rule**.

   ![Add Inbound Port rule](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/add-inbound-port-vm1.png?raw=true)


10. Under **Add inbound security rule**:

   - Add **Destination Port Range** as **80**
   
   - **Name** : **Port_80**

   - Click on **Add**

   ![port_80](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/add-port80.png?raw=true)
  
11. Repeat the step-9 to create **Port_443**

    - Add **Destination Port Range** as **443**

    - **Name** : **Port_443**

    - Click on **Add**

   ![Port 443](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/add-port-443.png?raw=true)

   
## Task 3: Configure NSGs/ASGs and allow Application Access


### Overview

In this task, you will create a Network Security Group and access for Application.

1. From your **LABVM**, select **Network Security Group** and Click on **Create**.

   ![NSG](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/create%20nsg.png?raw=true)
   
2. On the Create an network security group blade, on the Basics tab, enter the following information, and select Review + create:

   - **Resource Group** : Select your resource group **hands-on-lab-<inject key="DeploymentID" enableCopy="false"/>"

   - **Name** : **NSG-<inject key="DeploymentID" enableCopy="false"/>**.

   ![NSG](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/createNSG.png?raw=true)
   
3. Monitor the deployment status by selecting Notifications Bell at the top of the portal. In a minute or so, you should see a confirmation of the successful deployment. Select Go    to Resource.

    ![go to resource](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/NSG2.png?raw=true)
    
4. Now go back to the VM we created in task-1, click on **Connect** to connect RDP 

    ![connect](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/connect-RDP.png?raw=true)
    
5. Now click on **Download RDP File** and open VM after it got downloaded.

    ![download rdp file](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/downloadRDP-VM1.png?raw=true)
    
6. Provide the below details to connect VM

    - **User Name**  : **.\demouser**

    - **Password**   : **Password.1!!**

7. After connecting to the VM, you wil be promted with the **Networks** dialogue box then click on **Yes**.

    ![networks](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/networks-in-VM1.png?raw=true)
    
8. Minimize the **Server Manager** tab.

9. Click on the Windows icon at left-bottom corner and search for **Powershell ISE** then run it as Administrator.

10. Enter the below command in Powershell and Click on **Run**.

     * Install-WindowsFeature -name Web-Server -IncludeManagementTools

     ![Run app](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/runcommand.png?raw=true)
     
11. After running the command successfully, close the RDP and go back to the **Overview** of **VM-<inject key="DeploymentID" enableCopy="false"/>**.

12. Now copy the **Public IP** of **VM-<inject key="DeploymentID" enableCopy="false"/>** and browse it in new tab.

13. You will get the web page as mentioned in below screenshot.

    ![webapp](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/webapp.png?raw=true)
   
   
 ## Task 3 : Setup Load Balancing 
 
 ### Task 3.1 : Provision Secondary VM
 
 
 ### Overview
 
    In this task you will be creating seconday VM under same Availability Set.
    
1. From your **LABVM**, select **+ Create a resource**.

     ![Create resource](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/createRS.png?raw=true)
    
2. Search for **Virtual Machine** and Click on **Create**

     ![VM](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/VM.png?raw=true)
     
3. Enter the following instructions to create secondary VM

      - need to add

     ![Secondary VM](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/createVM2.png?raw=true)
     
4.

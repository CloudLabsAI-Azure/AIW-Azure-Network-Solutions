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

   
   

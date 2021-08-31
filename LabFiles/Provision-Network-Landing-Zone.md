
# Exercise 2: Provision Network Landing Zone

Duration: 15 mins

## Overview

In this exercise, you will create a virtual network and provision subnets for different scenarios.

This exercise includes the following tasks:

* Provision Virtual Network 
* Provision of subnets for AVD, Internal, DMZ scenarios


## Task 1: Provision Virtual Network 

### Overview

In this task, you will create a virtual network




1.  From the **Azure portal**, select **+ Create a resource**.

     ![Create resource](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/createRS.png?raw=true)
     
2.  In the **Search the Marketplace** box, choose **Networking**, then **Virtual network**, and then **Create**. 

     ![Create Resource](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/netvnet.png?raw=true)
     
3. On the **Basics** tab of **Create virtual network**, enter the following information and select **Review + Create**.

    -  Subscription: **Select your subscription**.
  
    -  Resource group: Select resource group from drop down list **hands-on-lab-<inject key="DeploymentID" enableCopy="false"/>** .

    -  Name: **NSVnet-<inject key="DeploymentID" enableCopy="false"/>**

    -  Location: **East US**

     ![move to IP address](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/vnet.png?raw=true)

7.  Review the configuration and select **Create**.

     ![VNet Creation](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/createVnet1.png?raw=true)

8.  Monitor the deployment status by selecting **Notifications Bell** at the top of the portal. In a minute or so, you should see a confirmation of the successful deployment. Select **Go to Resource**.

     ![vnet notification](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/vnetgoto.png?raw=true)

## Task 2: Provision of subnets
  
### Overview

In this task, you will create a Subnet for different scenarios like AVD, DMZ, Internal.




1.  Select **Address Space** from the left-hand menu in the newly established VNet.
    
     - Add **Address Space** : **10.0.0.0/20**

     -  Click on **Save**

     ![Address space](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/nsvnet.png?raw=true)
     
2.  Now select **Subnets** from NSVnet-<inject key="DeploymentID" enableCopy="false"/> blade and Click on **+Subnet**

      ![Subnet](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/subnet.png?raw=true)
      
3. Under **Add Subnet** 

    - Name : **AVD**
    - Subnet Address Range : **10.0.0.0/24**
    - Select **Save**

    ![AVD](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/AVD1.png?raw=true)
    
4. Repeat the step-2 for creating **DMZ** subnet

    - **Name** : **DMZ**
    - **Subnet Address Range** : **10.0.2.0/25**
    - Select **Save**

    ![DMZ](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/DMZ1.png?raw=true)
    
5. Repeat the step-3 for creating **Internal** subnet

    - **Name** : **Internal**
    - **Subnet Address Range** : **10.1.2.0/24** (Make sure that Subnet Address Range is within the range of default Address Space of VNet)
    - Select **Save**
    
    ![Internal](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/internnal2.png?raw=true)

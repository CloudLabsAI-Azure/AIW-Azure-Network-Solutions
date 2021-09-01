
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




1.  Select **Show portal menu** from the upper left corner of the Azure Portal's **Home** page and then **Create a resource**.

      ![Create resource](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/createres.png?raw=true)
     
2.  Select **Networking** from **Azure Marketplace**, then click on **Virtual Network**.

     ![Create Resource](https://user-images.githubusercontent.com/83349577/131707021-540299f2-c399-4e82-b2b5-0eaedd86925e.png)
     
3. On the **Basics** tab of **Create virtual network**, enter the following information and select **Review + Create**.

    -  Subscription: **Select your subscription**.
  
    -  Resource group: Select resource group from drop down list **hands-on-lab-<inject key="DeploymentID" enableCopy="false"/>** .

    -  Name: **NSVnet-<inject key="DeploymentID" enableCopy="false"/>**

    -  Location: **East US**

     ![move to IP address](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/createVirtualNet.png?raw=true)

4.  Review the configuration and select **Create**.

     ![VNet Creation](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/createVnet1.png?raw=true)

5.  Monitor the deployment status by selecting **Notifications Bell** icon at the top of the portal. In a minute or so, you should see a confirmation of the successful deployment. Select **Go to Resource**.

     ![vnet notification](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/notifi.png?raw=true)

## Task 2: Provision of subnets
  
### Overview

In this task, you will create a Subnet for different scenarios like AVD, DMZ, Internal.



     
1.  Select **Subnets** from NSVnet-<inject key="DeploymentID" enableCopy="false"/> blade and Click on **+Subnet**

      ![Subnet](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/sunets.png?raw=true)
      
2. Provide the following instructions under **Add Subnet** to create **AVD** subnet.

    1 Name : **AVD**
    
    2 Subnet Address Range : **10.1.1.0/24**
    
    3 Select **Save**

    ![AVD](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/AVD1.png?raw=true)
    
3. Repeat the step-1 for creating **DMZ** subnet and provide the below mentioned instructions.

    1 **Name** : **DMZ**
    
    2 **Subnet Address Range** : **10.1.2.0/24**
    
    3 Select **Save**

    ![DMZ](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/DMZ1.1.png?raw=true)
    
4. Repeat the step-1 for creating **Internal** subnet and provide the below mentioned instructions.

    1 **Name** : **Internal**
    
    2 **Subnet Address Range** : **10.1.3.0/24** 
    
    3 Select **Save**
    
    ![Internal](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/Interna;.png?raw=true)

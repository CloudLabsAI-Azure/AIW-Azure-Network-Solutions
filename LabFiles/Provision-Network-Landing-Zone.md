
# Exercise 2: Provision Network Landing Zone

Duration: 15 mins

## Overview

In this exercise, you will create a virtual network and provision subnets for different scenarios.

This exercise includes the following tasks:

* Provision Virtual Network 
* Provision of subnets for AVD, Internal, DMZ scenarios


## Task 1: Provision Virtual Network 

1.  From your **LABVM**, connect to the Azure portal, select **+ Create a resource**, and in the **Search the Marketplace** box, search for and select **Virtual network** and select **Create**.

     ![Create resource](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/createRS.png?raw=true)
     
2. On the **Create virtual network** blade, on the **Basic** tab, enter the following information:

    -  Subscription: **Select your subscription**.
  
    -  Resource group: Select resource group from drop down list.

    -  Name: **NSVnet**

    -  Location: **East US**

3.  Select **Next: IP Addresses**

     ![In this screenshot, the Basics tab of the 'Create virtual network' blade is depicted with the configuration options specified in the previous selected and the 'Next: IP Addresses' button selected.]("https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/VN2.png?raw=true")
    
4.  Leave everything as default for now.

5.  Select **Review + Create**.

6.  Review the configuration and select **Create**.

7.  Monitor the deployment status by selecting **Notifications Bell** at the top of the portal. In a minute or so, you should see a confirmation of the successful deployment. Select **Go to Resource**.

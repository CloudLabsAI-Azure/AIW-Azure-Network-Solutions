
# Exercise 2: Provision Network Landing Zone

Duration: 15 mins

## Overview

In this exercise, you will create a virtual network and provision subnets for different scenarios.

This exercise includes the following tasks:

* Provision Virtual Network 
* Provision of subnets for AVD, Internal, DMZ scenarios


## Task 1: Provision Virtual Network 

1. Navigate to the Azure portal home (<https://portal.azure.com>) and click on **Create a resource** .

    ![Portal](media/portal.png)
    
2. In the **Search the Marketplace** box, search for and select **Virtual network** and select **Create**. 

    ![Vnet](media/VNet.png)
    
3.  On the **Create virtual network** blade, on the **Basic** tab, enter the following information:

    -  Subscription: **Select your subscription**.
  
    -  Resource group: Select **Create new**, and enter the name **aiw-networking-**.

    -  Name: **WSVnet**

    -  Region: **East US**

4. Select **Next: IP Addresses**.
 
    ![Vnwtwork](media/vnet1.0.png)
    
5.  On the **Create virtual network - IP Addresses** tab, enter the following information:

    -  IPv4 Address space: **10.0.0.0/16**

6. Click on **Review and Create**.

    ![Vnet creation](media/vnet2.png)
    
7. Review the configuration and select **Create**.

8. Select **Go to Resource**.

   ![Vnet creation](media/vnet3.png)
   
9. Under **WSVnet** blade
 
    - Select **Address Space**

    - Add  **10.0.0.0/24** under Address Space

    - Select **Save**

    ![Address Space](media/as.png)
    
10.In the **Subnets** blade select **+Subnet**.

    ![In the Subnets blade, the add Subnet button is selected.](media/subnet.png)
    
11.  On the **Add subnet** blade, enter the following information:

    -  Name: **AVD**

    -  Address range: **10.0.0.0/24**

    -  Service Endpoints: **Leave as Default**.
    
12.  When your dialog looks like the following screenshot, select **Save** to create the subnet.

    ![In this screenshot, the 'Add subnet' blade of the Azure portal is depicted with the settings specified in the previous step selected.]("media/subnet1.png")
    
13. Repeat Step 10, enter the following information for DMZ. 

    -  Name: **DMZ** 

    -  Address range: **10.0.2.0/25**
    -  

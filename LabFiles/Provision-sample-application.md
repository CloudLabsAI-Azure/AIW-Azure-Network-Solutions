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


## Task 1: Deploy VM using pre-built ARM Template in existing network. 

### Overview

In this task, you will be deploying a virtual machine without public IP address using ARM template.

1. Search for the **Templates** in the search box from **Azure Portal** and select **Template deployment (deploy using custom templates)** from **Market Place**.

    ![template](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/template.png?raw=true)
    
2. Now select **Build your own template in the editor** from **Custom deployment** tab.

    ![template deployment](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/customdep.png?raw=true)
    
3. Now copy the below code and paste it in work space

    ```json
    {
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "azureUsername": {
            "type": "String"
        },
        "azurePassword": {
            "type": "SecureString"
        },
        "deploymentID": {
            "type": "String"
        },
        "InstallCloudLabsShadow": {
            "defaultValue": "no",
            "allowedValues": [
                "yes",
                "no"
            ],
            "type": "String"
        }
    },
    "variables": {
        "azureTenantID": "[subscription().tenantId]",
        "azureSubscriptionID": "[subscription().subscriptionId]",
        "resourceGroupName": "[resourceGroup().name]",
        "location": "[resourceGroup().location]",
        "availabilitySetName": "[concat('ANS-AS-',parameters('deploymentID'))]",
        "availabilitySetPlatformFaultDomainCount": "2",
        "jumphost": "[concat('VM1-',parameters('deploymentID'))]",
        "adminUsername": "demouser",
        "adminPassword": "Password.1!!",
        "availabilitySetPlatformUpdateDomainCount": "5",
        "networkInterfaceName1": "[concat(variables('jumphost'), '-nic')]",
        "virtualMachineSize": "Standard_D2s_v3",
        "vmPublicIpDnsName": "[concat('labvm',uniqueString(resourceGroup().id))]",
        "apiVersion": "[providers('Microsoft.ServiceBus', 'namespaces').apiVersions[0]]",
        "rgName": "Anusha",
        "virtualNetworkName": "[concat('NSVnet-',parameters('deploymentID'))]",
        "SubnetName": "Internal",
        "subnetRef": "[resourceId(variables('rgName'),'Microsoft.Network/virtualNetworks/subnets', variables('virtualNetworkName'), variables('SubnetName'))]"
    },
    "resources": [
        {
            "type": "Microsoft.Network/networkInterfaces",
            "apiVersion": "2016-09-01",
            "name": "[variables('networkInterfaceName1')]",
            "location": "[variables('location')]",
            "dependsOn": [],
            "properties": {
                "ipConfigurations": [
                    {
                        "name": "ipconfig1",
                        "properties": {
                            "subnet": {
                                "id": "[variables('subnetRef')]"
                            },
                            "privateIPAllocationMethod": "Dynamic"
                        }
                    }
                ]
            }
        },
        {
            "type": "Microsoft.Compute/virtualMachines",
            "apiVersion": "2021-03-01",
            "name": "[variables('jumphost')]",
            "location": "[variables('location')]",
            "dependsOn": [
                "[concat('Microsoft.Network/networkInterfaces/', variables('networkInterfaceName1'))]",
                "[concat('Microsoft.Compute/availabilitySets/', variables('availabilitySetName'))]"
            ],
            "properties": {
                "hardwareProfile": {
                    "vmSize": "[variables('virtualMachineSize')]"
                },
                "storageProfile": {
                    "osDisk": {
                        "createOption": "fromImage",
                        "managedDisk": {
                            "storageAccountType": "Premium_LRS"
                        }
                    },
                    "imageReference": {
                        "publisher": "MicrosoftWindowsServer",
                        "offer": "WindowsServer",
                        "sku": "2019-datacenter-gensecond",
                        "version": "latest"
                    }
                },
                "networkProfile": {
                    "networkInterfaces": [
                        {
                            "id": "[resourceId('Microsoft.Network/networkInterfaces', variables('networkInterfaceName1'))]"
                        }
                    ]
                },
                "osProfile": {
                    "computerName": "[variables('jumphost')]",
                    "adminUsername": "[variables('adminUsername')]",
                    "adminPassword": "[variables('adminPassword')]",
                    "windowsConfiguration": {
                        "enableAutomaticUpdates": true,
                        "provisionVmAgent": true
                    }
                },
                "availabilitySet": {
                    "id": "[resourceId('Microsoft.Compute/availabilitySets', variables('availabilitySetName'))]"
                }
            }
        },
        {
            "type": "Microsoft.Compute/availabilitySets",
            "apiVersion": "2019-07-01",
            "name": "[variables('availabilitySetName')]",
            "location": "[variables('location')]",
            "sku": {
                "name": "Aligned"
            },
            "properties": {
                "platformFaultDomainCount": "[variables('availabilitySetPlatformFaultDomainCount')]",
                "platformUpdateDomainCount": "[variables('availabilitySetPlatformUpdateDomainCount')]"
            }
        }
    ],
     "outputs": {}
     }
 
4. Make sure you change the Resource Group in template and verify the subnet name once, then **Save** the template.

    - Resource group : **hands-on-lab-<inject key="DeploymentID" enableCopy="true"/>**

    - Subnet Name : **Internal**

    ![template](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/edit-template.png?raw=true)
    
5. Follow the instructions mentioned below to create the VM.

    - Resource Group : **hands-on-lab-<inject key="DeploymentID" enableCopy="true"/>**

    - User name : **demouser**

    - Password : **Password.1!!**

    - Click on **Review + Create**

      ![template deployment](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/customdep1.png?raw=true)
      
 6. Review the template and select **Create**

      ![template deployment](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/customdep2.png?raw=true)
      
7. After the creation of template is succeeded click on **Go to Resource**

    ![go to resource](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/VMgotores.png?raw=true)


## Task 2: Add Public IP to the virtual machine

### Overview

In this task, you will associate the IP Address to Virtual Machine


1. Navigate to the newly deployed virtual machine and notice there is no public ip associated.

   ![noIP](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/NoIp-VM1.png?raw=true)
   
2. Now click on **Home** from top left corner and navigate to the **Azure Portal** then select **+ Create a resource**.

     ![Create resource](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/createRS.png?raw=true)
     
3. Search for **Public IP Address** from the home page of **Azure Portal** and Click on **Create**

    ![create Vnet](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/public-IP.png?raw=true)
    
4. Enter the following information to create Public IP Address:

   1 SKU  : **Standard**

   2 Tier : **Regional**

   3 Name : **PublicIP1-<inject key="DeploymentID" enableCopy="false"/>**

   4 Choose your **Subscription Group**

   5 Resource Group : **hands-on-lab-<inject key="DeploymentID" enableCopy="false"/>**

   6 Click on **Create**.

   ![createIP](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/cete-pip.png?raw=true)
   
5. Monitor the deployment status by selecting **Notifications** Bell at the top of the portal. In a minute or so, you should see a confirmation of the successful deployment. Select  **Go to Resource**.

  ![Create IP](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/notifi.png?raw=true)

6. Click on **Associate** to associate the Public IP to VM and use the following instructions under **Associate Public IP address**

   1. Resource Type : Select **Network Interface** from drop down.

   2. Network Interface : Select Network Interface of the newly deployed VM.

   3. Click on **OK**

   ![AssociatePIP](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/Assopip.png?raw=true)
   
7. Now navigate back to the Virtual Machine by selecting **Home** button and you can observe the Public Ip in **Overview** tab of Virtual Machine.

   ![PIP](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/changed%20Public%20IP%20in%20VM1.png?raw=true)
   
   
## Task 3: Configure NSGs/ASGs and allow Application Access


### Overview

In this task, you will create a Network Security Group and access for Application.

1. From your **Azure Portal**, select **Network Security Group** and click on **Create**.

   ![NSG](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/create%20nsg.png?raw=true)
   
2. On the **Basics** tab of  Create an network security group enter the following information, and select **Review + create**:

   - Resource Group : Select your resource group **hands-on-lab-<inject key="DeploymentID" enableCopy="false"/>"

   - Name : **NSG-<inject key="DeploymentID" enableCopy="true"/>**.

   ![NSG](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/nsg1.png?raw=true)
   
3. Monitor the deployment status by selecting **Notifications** Bell at the top of the portal. In a minute or so, you should see a confirmation of the successful deployment. Select **Go to Resource**.

    ![go to resource](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/notifi1.png?raw=true)
    
4. To associate NSG to the deployed VM follow the below instructions

     1. Select **Network Interface**

     2. Click on **Associate**

     3. Under the **Network interface associations** select **nic** of **VM1-<inject key="DeploymentID" enableCopy="false"/>**

     4. Click on **Ok**

      ![Associate NSG to VM](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/nic-nsg.png?raw=true)
      
5. On **Network Security Group** blade, under **Settings** Select **Inbound security Rules** and click on **Add**.

6.  Under **Add inbound security rule**:

     - Add **Destination Port Range** as **3389**
   
     - Name : **RDP**

     - Click on **Add**   

        ![Add RDP](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/add-rdp.png?raw=true)


7. Repeat the step-5 to create **Port_80**

   - Add **Destination Port Range** as **80**
   
   - Name : **Port_80**

   - Click on **Add**

   ![port_80](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/add-80.png?raw=true)
  
8. Repeat the step-5 to create **Port_443**

    - Add **Destination Port Range** as **443**

    - Name : **Port_443**

    - Click on **Add**

   ![Port 443](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/add-443.png?raw=true)

9. Now navigate back to the VM we created in task-1, click on **Connect** to connect RDP 

    ![connect](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/connect-RDP.png?raw=true)
    
10. Now click on **Download RDP File** and open VM after it got downloaded.

    ![download rdp file](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/downloadRDP-VM1.png?raw=true)
    
11. Provide the below details to connect VM

    - User Name  : **.\demouser**

    - Password   : **Password.1!!**

12. After connecting to the VM, you wil be promted with the **Networks** dialogue box then click on **Yes**.

    ![networks](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/networks-in-VM1.png?raw=true)
    
13. Minimize the **Server Manager** tab.

14. Click on the Windows icon at left-bottom corner and search for the **Powershell ISE** then run it as Administrator.

15. Enter the below command in Powershell and Click on **Run**.

     * Install-WindowsFeature -name Web-Server -IncludeManagementTools

     ![Run app](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/runcommand.png?raw=true)
     
 ## Task-4 : Test Application 
 
 
 ### Overview
  
  In this task you will check wheater the we are able to connect to the created application.
     
1. After running the command successfully, close the RDP and go back to the **Overview** of **VM-<inject key="DeploymentID" enableCopy="false"/>**.

2. Now copy the **Public IP** of **VM1-<inject key="DeploymentID" enableCopy="false"/>** and browse it in new tab.

3. You will get the web page as mentioned in below screenshot.

    ![webapp](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/webapp.png?raw=true)
   
   
## Task 5 : Setup Load Balancing 
 
## Task 5.1 : Provision Secondary VM
 
 
 ### Overview
 
    In this task you will be creating seconday VM under same Availability Set.
    
1. From your **Azure Portal**, select **+ Create a resource**.

     ![Create resource](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/createRS.png?raw=true)
    
2. Search for **Virtual Machine** and click on **Create**

     ![VM](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/VM.png?raw=true)
     
3. Enter the following instructions to create secondary VM

      1. Virtual machine name : **VM2-<inject key="DeploymentID" enableCopy="false"/>**

      2. Availability options : Select **Availability set** from drop down

      3. Availability Set : **ANS-AS-<inject key="DeploymentID" enableCopy="false"/>**

      4. Username : **demouser**

      5. Password : **Password.1!!**

      6. Confirm Password : **Password.1!!**

      7. Select **Next:Disks**

     ![Secondary VM](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/vm2-create.png?raw=true)
     
4. Leave everything as default in Disks tab and move to **Networking**
     
5. After moving to the **Networking** tab, under **Public IP** select **Create new** and make sure you select **SKU** as **Standard** for Public IP and click on **OK**.

    ![Standard IP](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/vm2-ip.png?raw=true)
     
6. Select Subnet as **Internal** and click on **Review and Create**.

    ![networking](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/createVM2-1.png?raw=true)
    
7.  Select **Load Balancer** from **LabVM**.

     ![LoadBalancer](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/LB.png?raw=true)
     
7. Under the **basic** tab of Load Balancer enter the following commands:

     - Resource Group : **hands-on-lab-<inject key="DeploymentID" enableCopy="false"/>**

     - Name  : **ANS-LB<inject key="DeploymentID" enableCopy="false"/>**

     - Type  : **Public**

     - Click on **Frontend IP Configuration**

        ![Basic LB](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/Create%20LB.png?raw=true)
        
8.  Click on **Add a frontend IP**

       ![frontendIP](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/Front%20endIP.png?raw=true)
       
9.  Enter the following instructions to create **Frontend IP** :

     - Name : **FIP-<inject key="DeploymentID" enableCopy="false"/>**

     - IP Version : **IPv4**

     - IP type : **IP Address**

     - Under **Public IP address** click on **Create new**
      
     -  Now add **Name** as **PublicIP-<inject key="DeploymentID" enableCopy="false"/>** ,click on **Ok**.

       ![frontendIP](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/FrontendIP.png?raw=true)
       
10. Now click on **Add**.

     ![add frontend ip](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/Add%20frontend%20ip%20address.png?raw=true)
    
11. After adding frontend IP Address should see the screen as mentioned in below Screen shot and click on **Backend Pool**

    ![next to backend pool](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/Next-to-backendpool.png?raw=true)
    
12. Follow the below instructions to create **Backend Pool**

     - **Name** : **BackendPool-<inject key="DeploymentID" enableCopy="false"/>**

     - **Virtual Network** : Select the created Vnet **

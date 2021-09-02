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

     * Provision Secondary VM.
       
     * Provision Load Balancing using External Load Balancer. 
       
     * Test LB & VM failover.


## Task 1: Deploy VM using pre-built ARM Template in existing network. 

### Overview

In this task, you will be deploying a virtual machine without public IP address using ARM template.

1. Search for **templates** in the azure portal's search box, then pick **Template deployment (deploy using custom templates)** under market place.

    ![template](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/template.png?raw=true)
    
2. Now select **Build your own template in the editor** from **Custom deployment** tab.

    ![template deployment](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/customdep.png?raw=true)
    
3. Copy the json script below and paste it into the editor to replace the existing script.

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
        "rgName": "hands-on-lab-",
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
        },
        {
            "type": "Microsoft.Compute/virtualMachines/extensions",
            "apiVersion": "2015-06-15",
            "name": "[concat(variables('jumphost'),'/', 'winExtension')]",
            "location": "[resourceGroup().location]",
            "dependsOn": [
                "[concat('Microsoft.Compute/virtualMachines/', variables('jumphost'))]"
            ],
            "tags": {
                "displayName": "VM Extension"
            },
            "properties": {
                "publisher": "Microsoft.Compute",
                "type": "CustomScriptExtension",
                "typeHandlerVersion": "1.8",
                "autoUpgradeMinorVersion": true,
                "settings": {
                    "fileUris": [
                        "https://raw.githubusercontent.com/Divyasri199/Templates/main/netsol.ps1"
                    ]
                },
                "protectedSettings": {
                    "commandToExecute": "powershell.exe -ExecutionPolicy Unrestricted -File netsol.ps1"
                }
            }
        }
    ],
    "outputs": {}
    }
 
4. Replace the Resource Group name in the template with the below mentioned RGName and double-check the subnet name, then **Save** the template.

    - rgName : **hands-on-lab-<inject key="DeploymentID" enableCopy="true"/>**

    - Subnet Name : **Internal**

    ![template](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/rgName.png?raw=true)
    
5. Enter the following information to create the VM.

    1 Resource Group : **hands-on-lab-<inject key="DeploymentID" enableCopy="true"/>**

    2 User name : **demouser**

    3 Password : **Password.1!!**
    
    4. Deployment ID: **<inject key="DeploymentID" enableCopy="true"/>**


    5 Click on **Review + Create**

      ![template deployment](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/arm.png?raw=true)
      
 6. Review the template and select **Create**

      ![template deployment](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/customdep2.png?raw=true)
      
7. After the template has been successfully created, click **Go to Resource**.

    ![go to resource](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/vmgoto.png?raw=true)


## Task 2: Add Public IP to the virtual machine

### Overview

In this task, you will associate the Public IP Address to Virtual Machine under same Vnet.


1. Navigate to the resource group **hands-on-lab-<inject key="DeploymentID" enableCopy="false"/>** and select the virtual machine **VM1-<inject key="DeploymentID" enableCopy="false"/>** from **Overview** tab

   ![vm1.1](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/selectVM.png?raw=true)
   
2. You can observe that the virtual machine doesn't have a public IP address from the **Overview** tab.

   ![noIP](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/nopublicIPadd.png?raw=true)
   
3. Navigate to the **Azure Portal** by selecting the **Home** from top left corner and then select **+ Create a resource**.

     ![Create resource](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/createRS.png?raw=true)
     
4. Search for **Public IP Address** from the home page of **Azure Portal** and select it.

     ![publicip](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/publicip.png?raw=true)
     
5. Now click on **Create**

    ![create Vnet](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/public-IP.png?raw=true)
    
6. Provide the following information to create Public IP Address:

   1 SKU  : **Standard**

   2 Tier : **Regional**

   3 Name : **PublicIP1-<inject key="DeploymentID" enableCopy="false"/>**

   4 Choose your **Subscription Group**

   5 Resource Group : **hands-on-lab-<inject key="DeploymentID" enableCopy="false"/>**

   6 Click on **Create**.

   ![createIP](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/createPubIP.png?raw=true)
   
7. Monitor the deployment status by selecting **Notifications** Bell icon at the top of the portal. In a minute or so, you should see a confirmation of the successful deployment. Select  **Go to Resource**.

    ![Create IP](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/gotoPubIP.png?raw=true)

8. To associate the Public IP address with the VM, click on **Associate** and follow the procedures mentioned below inside the  **Associate Public IP address** tab.

   1. Resource Type : Select **Network Interface** from drop down.

   2. Network Interface : Select Network Interface of the newly deployed VM.

   3. Click on **OK**

   ![AssociatePIP](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/AssPubip.png?raw=true)
   
9. Return to the resource group and select the **VM1-<inject key="DeploymentID" enableCopy="false"/>** from the **Overview** tab.

10. You can observe the corresponding **Public IP address** on the virtual machine's **Overview** tab.

   ![PIP](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/PUbIpcreated.png?raw=true)
   
   
## Task 3: Configure NSGs/ASGs and allow Application Access


### Overview

In this task, you will create a Network Security Group and access for Application.

1. From your **Azure Portal**, select **Network Security Group** and click on **Create**.

   ![NSG](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/create%20nsg.png?raw=true)
   
2. On the **Basics** tab of  Create network security group enter the following information, and select **Review + create**:

   - Resource Group : Select your resource group **hands-on-lab-<inject key="DeploymentID" enableCopy="false"/>**

   - Name : **NSG-<inject key="DeploymentID" enableCopy="true"/>**.

   ![NSG](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/nsg1.png?raw=true)
   
3. Monitor the deployment status by selecting **Notifications** Bell at the top of the portal. In a minute or so, you should see a confirmation of the successful deployment. Select **Go to Resource**.

    ![go to resource](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/notifi1.png?raw=true)
    
4. Follow the below instructions to associate NSG to the deployed VM

     1. Select **Network Interface**

     2. Click on **Associate**

     3. Under the **Network interface associations** select **nic** of **VM1-<inject key="DeploymentID" enableCopy="false"/>**

     4. Click on **Ok**

      ![Associate NSG to VM](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/nic-nsg.png?raw=true)
      
5. On the **Network Security Group** blade, Select **Inbound security Rules** from **Settings** and click on **Add**.

      ![nsg](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/nsg2.2.png?raw=true)

6.  Provide the following information under **Add inbound security rule**:

     - Add **Destination Port Range** as **3389**
   
     - Name : **RDP**

     - Click on **Add**   

        ![Add RDP](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/nsg2.3.png?raw=true)


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

     
 ## Task-4 : Test Application 
 
 
 ### Overview
  
  In this task you will check wheater the we are able to connect to the created application.
     
1. Navigate to the resource group **hands-on-lab-<inject key="DeploymentID" enableCopy="false"/>** and select the virtual machine **VM1-<inject key="DeploymentID" enableCopy="false"/>** from **Overview** tab

   ![vm1.1](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/selectVM.png?raw=true)

2. Now, copy the **Public IP address**  from the virtual machine's **Overview** page and paste it in new tab

   ![PIP](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/PUbIpcreated.png?raw=true)
   
3. You'll be directed to the webpage shown in the screenshot below.

    ![webapp](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/website.png?raw=true)
   
   
## Task 5 : Setup Load Balancing 
 
## Task 5.1 : Provision Secondary VM
 
 
### Overview
 
    In this task you will be creating seconday VM under same Availability Set.
    
1. Follow the actions mentioned in **Task 1** from step 1 to step 7 to create the secondary VM 
 
2. To change the name of the VM update the line number **30** with the following command **[concat('VM2-',parameters('deploymentID'))]** in ARM template

     ![vm2](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/changevm2.png?raw=true)
     
3. Once the deployment is complete, move back to the resource group and select **VM2-<inject key="DeploymentID" enableCopy="false"/>**.

4. You can observe that the virtual machine doesn't have a **Public IP address** from the **Overview** tab.

     ![nopip](https://user-images.githubusercontent.com/83349577/131731790-62fec26c-71f5-427d-9f6a-b6f15f100ff3.png)
     
5. Now, we need to create a Public Ip address and associate it to **VM2-<inject key="DeploymentID" enableCopy="false"/>**

6.Navigate to the Azure Portal by selecting the Home from top left corner and then select + Create a resource.

   ![Create resource](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/createRS.png?raw=true)
     
7. Search for **Public IP Address** from the home page of **Azure Portal** 

     ![publicip](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/publicip.png?raw=true)
     
8. Now click on **Create**

    ![create Vnet](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/public-IP.png?raw=true)

9. Provide the following information to create Public IP Address:

   1 SKU  : **Standard**

   2 Tier : **Regional**

   3 Name : **PublicIP2-<inject key="DeploymentID" enableCopy="false"/>**

   4 Choose your **Subscription Group**

   5 Resource Group : **hands-on-lab-<inject key="DeploymentID" enableCopy="false"/>**

   6 Click on **Create**.   
   
     ![pip2](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/pip2.png?raw=true)
     
10. Monitor the deployment status by selecting **Notifications** Bell icon at the top of the portal. In a minute or so, you should see a confirmation of the successful deployment. Select **Go to Resource**.

     ![pip](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/gotopip2.png?raw=true)
     
11. To associate the Public IP address with the VM, click **Associate** and follow the procedures mentioned below under  **Associate Public IP address** tab.

     1. Resource Type : Select **Network Interface** from drop down.

     2. Network Interface : Select Network Interface of the newly deployed VM.

     3. Click on **OK**

   ![AssociatePIP](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/asspip.png?raw=true)
   
12. Return to the resource group and select the **VM2-<inject key="DeploymentID" enableCopy="false"/>** from the **Overview** tab.

13. You can observe the corresponding **Public IP address** on the virtual machine's **Overview** tab.

   ![PIP](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/vm2pip1.png?raw=true)
   
14. Now, go back to the **Azure Portal** and seach for **Network Security Group**

    ![nsg](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/nsgselect.png?raw=true)
    
15. Select the **NSG-<inject key="DeploymentID" enableCopy="false"/>**.

16. Select **Network Interfaces** from **Settings** under **NSG-<inject key="DeploymentID" enableCopy="false"/>** tab and click on **Associate**
     
      ![nsg](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/Assnsg.png?raw=true)
      
17. Under **Network Interface Associations** select **VM2-<inject key="DeploymentID" enableCopy="false"/>-nic** and click on **OK**

     ![pip](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/assint.png?raw=true)
     
18. Navigate to the resource group **hands-on-lab-<inject key="DeploymentID" enableCopy="false"/>** and select the virtual machine VM2- from Overview tab

19. Now copy the Public IP address from the virtual machine's Overview page and paste it in new tab

      ![vm2pip](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/vm2pip1.png?raw=true)
      
20.  You'll be directed to the webpage with the name of VM2-<inject key="DeploymentID" enableCopy="false"/> shown in the screenshot below.

      ![vm2](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/webpage.png?raw=true)
     
## Task 5.2 : Provision Load Balancing using External Load Balancer 

### Overview

In this task, you will be creating an exertal load balancer
    
1. Search for the **Load balancer** from **Azure Portal** and select **Create**.
  
  ![create Loadbalancer](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/LB%20create.png?raw=true)
  
     
2. Under the **basic** tab of Load Balancer enter the following commands:

     - Resource Group : **hands-on-lab-<inject key="DeploymentID" enableCopy="false"/>**

     - Name  : **ANS-LB<inject key="DeploymentID" enableCopy="false"/>**

     - Type  : **Public**

     - Click on **Frontend IP Configuration**

        ![Basic LB](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/creatingLBB.png?raw=true)
        
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

     - **Name** : **BackendPool-<inject key="DeploymentID" enableCopy="true"/>**

     - **Virtual Network** : Select the created Vnet **NSVnet-<inject key="DeploymentID" enableCopy="true"/>** from drop down list

     -  Select **Add** to create add Virtual machines.

      ![add vm at backendpool](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/backendpoool.png?raw=true)
      
 13. To add the virtual machines in the backend pool, select both the VMs and click on **Add** 

     ![Add Vm at backendpool](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/add%202%20vms.png?raw=true)
     
 14. Now select existing **Add** button to **Add backend pool**

      ![add backendpool](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/add%20on%20add.png?raw=true)
      
15. After adding the virtual machines in the backend pool you can observe the screen as mentioned in below screenshot, after reviewing click on **Inbound rules**.

     ![review backendpools](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/reviewbackendpool.png?raw=true)
     
16. To create load balancing rule, click on **Add a load balancing rule** and following the below mentioned instructions:

     - Name : **LoadBalancing-<inject key="DeploymentID" enableCopy="true"/>**

     - Frontend IP address : **FIP-<inject key="DeploymentID" enableCopy="true"/>** from drop down list.

     - Port : **80**

     - Backend Port : **80**

     - Backend Pool : **BackendPool-<inject key="DeploymentID" enableCopy="true"/>** from drop down list.

     ![loadbalincing](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/Loadbalancing.png?raw=true)
     
     - Health Probe: To create health probe click on **create new** and mention **Name** as **HealthProbe-<inject key="DeploymentID" enableCopy="true"/>**, **Protocol** as         **HTTP** then select **Ok**

       ![health probe](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/healthprobe.png?raw=true)
       
      - TCP reset: **Enabled**

      - Select **Add**

17. After adding Load balancing rule click on **Review + Create** and select **Create**

      ![create lb](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/addedLB.png?raw=true)
      
      
##  Task- 5.3 : Test LB & VM failover.

1. After the deployment of Load balancer got succeeded, select on **Go to the resouce**

    ![go to resource](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/click%20on%20goto.png?raw=true)
    
2. Now you can find the same **Public Ip address** for Load balancer and previously deployed 2 virtual machines.

3. Copy the public Ip address and browse it in new tab, you can find the web page we had deployed in task-4

     ![web page](https://github.com/Divyasri199/AIW-Azure-Network-Solutions/blob/prod/media/webapp.png?raw=true)
     
4. To test for VM failover, go back to **VM1-<inject key="DeploymentID" enableCopy="false"/>** in the resource group **hands-on-lab-<inject key="DeploymentID" enableCopy="true"/>** and deallocate the VM  by clicking on **Stop**.

5. Navigate back to the browser where you accessed the public IP address and refresh the page, you can observe the change in VM name.

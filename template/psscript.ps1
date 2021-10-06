Param (
    [Parameter(Mandatory = $true)]
    [string]
    $location
)

Start-Transcript -Path C:\WindowsAzure\Logs\CloudLabsCustomScriptExtension.txt -Append
# To resolve the error of https://github.com/microsoft/MCW-App-modernization/issues/68. The cause of the error is Powershell by default uses TLS 1.0 to connect to website, but website security requires TLS 1.2. You can change this behavior with running any of the below command to use all protocols. You can also specify single protocol.
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls, [Net.SecurityProtocolType]::Tls11, [Net.SecurityProtocolType]::Tls12, [Net.SecurityProtocolType]::Ssl3
[Net.ServicePointManager]::SecurityProtocol = "Tls, Tls11, Tls12, Ssl3"

Install-WindowsFeature -Name "web-server" `
                       -IncludeManagementTools `
                       -IncludeAllSubFeature

#Download and Unpack the Website
$zipDownload = "https://github.com/CloudLabsAI-Azure/AIW-Azure-Network-Solutions/blob/main/template/WebApp.zip?raw=true"
#$zipDownload = "https://www.dropbox.com/s/wcfnuf76h3tn3ws/ContosoInsuranceIIS.zip?dl=1"
$downloadedFile = "C:\ContosoInsuranceIIS.zip"
$inetpubFolder = "C:\inetpub\wwwroot"
Invoke-WebRequest -Uri  $zipDownload -OutFile $downloadedFile
Add-Type -assembly "system.io.compression.filesystem"
[io.compression.zipfile]::ExtractToDirectory($downloadedFile, $inetpubFolder)

$srvname = "vm-contoso-frontend-prod-eastus-001"

(Get-Content -Path "C:\inetpub\wwwroot\Home.html") | ForEach-Object {$_ -Replace "computernamevalue", "$srvname"} | Set-Content -Path "C:\inetpub\wwwroot\Home.html"
(Get-Content -Path "C:\inetpub\wwwroot\Home.html") | ForEach-Object {$_ -Replace "azureregionvalue", "$location"} | Set-Content -Path "C:\inetpub\wwwroot\Home.html"
(Get-Content -Path "C:\inetpub\wwwroot\index.html") | ForEach-Object {$_ -Replace "azureregionvalue", "$location"} | Set-Content -Path "C:\inetpub\wwwroot\index.html"
(Get-Content -Path "C:\inetpub\wwwroot\index.html") | ForEach-Object {$_ -Replace "computernamevalue", "$srvname"} | Set-Content -Path "C:\inetpub\wwwroot\index.html"
(Get-Content -Path "C:\inetpub\wwwroot\index.html") | ForEach-Object {$_ -Replace "Sample text. replace the text with some story line", "Contoso Insurance (CI), headquartered in Miami, provides insurance solutions across North America. Its products include accident and health insurance, life insurance, travel, home, and auto coverage. <br> <br> Contoso insures that they have the right breadth and depth of continuity protection.  Contoso will evenly distribute the load across the backend servers to serve the request in time. Based on the demand, contoso will scale the application and create highly available services to handle the requests efficiently. <br> <br> In case of a lights-out event, they will be able to control the systems failover with zero downtime."} | Set-Content -Path "C:\inetpub\wwwroot\index.html"
(Get-Content -Path "C:\inetpub\wwwroot\Home.html") | ForEach-Object {$_ -Replace "Sample text. replace the text with some story line", "Contoso Insurance (CI), headquartered in Miami, provides insurance solutions across North America. Its products include accident and health insurance, life insurance, travel, home, and auto coverage. <br> <br> Contoso insures that they have the right breadth and depth of continuity protection.  Contoso will evenly distribute the load across the backend servers to serve the request in time. Based on the demand, contoso will scale the application and create highly available services to handle the requests efficiently. <br> <br> In case of a lights-out event, they will be able to control the systems failover with zero downtime."} | Set-Content -Path "C:\inetpub\wwwroot\index.html"


Function InstallEdgeChromium
{
    #Download and Install edge
    $WebClient = New-Object System.Net.WebClient
    $WebClient.DownloadFile("https://msedge.sf.dl.delivery.mp.microsoft.com/filestreamingservice/files/59c478d3-513a-4060-837b-01ad385d6aaa/MicrosoftEdgeEnterpriseX86.msi","C:\Packages\MicrosoftEdgeBetaEnterpriseX64.msi")
    sleep 5
    
    Start-Process msiexec.exe -Wait '/I C:\Packages\MicrosoftEdgeBetaEnterpriseX64.msi /qn' -Verbose 
    sleep 5
    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut("C:\Users\Public\Desktop\Azure Portal.lnk")
    $Shortcut.TargetPath = """C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"""
    $argA = """https://portal.azure.com"""
    $Shortcut.Arguments = $argA 
    $Shortcut.Save()

}
InstallEdgeChromium

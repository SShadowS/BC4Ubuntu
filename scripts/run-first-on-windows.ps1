# Mandatory config
$license = 'C:\bc4ubuntu\License.flf'
$sastoken = '?sv=....'

# Optional config
$workfolder = 'c:\bc4ubuntu'
$container = 'bc4ubuntu'
$encryptionkey = "$($workfolder)\secret.key"

#Some might need to run this first
#Install-Module PowershellGet -Force

New-Item $workfolder -ItemType Directory -ErrorAction Ignore
Set-Location $workfolder
Install-Module BcContainerHelper -Force
Import-Module BcContainerHelper
$password = ConvertTo-SecureString '1234' -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ('bc', $password)

$ArtifactInsider = Get-BCArtifactUrl -country gb -type Sandbox -select NextMajor -sasToken $sastoken
$artifactfolders = Download-Artifacts -includePlatform $ArtifactInsider
Compress-Archive -Path "$($artifactfolders[1])\ServiceTier" -DestinationPath ServiceTier.zip
New-BcContainer -Credential $credential -accept_eula -accept_outdated -assignPremiumPlan -auth NavUserPassword -containerName $container -isolation process -licenseFile $license -shortcuts DesktopFolder -updateHosts -useBestContainerOS -artifactUrl $ArtifactInsider

Invoke-scriptInBcContainer $containerName -scriptBlock {
    $password = ConvertTo-SecureString '1234' -AsPlainText -Force
    $credential = New-Object System.Management.Automation.PSCredential ('bc', $password)
    New-NAVEncryptionKey -KeyPath c:\run\secret.key
    Import-NAVEncryptionKey -KeyPath c:\run\secret.key -ServerInstance BC -ApplicationDatabaseServer localhost -ApplicationDatabaseCredentials $credential -ApplicationDatabaseName CRONUS -Force
}
Copy-FileFromBcContainer -containerName $container -localPath $encryptionkey -containerPath c:\run\secret.key
Copy-FileFromBcContainer -containerName $container -localPath $customsettings -containerPath "C:\Program Files\Microsoft Dynamics NAV\220\Service\CustomSettings.config"

# Start webserver to serve the encryption key
wget https://github.com/cesanta/binary/releases/download/exe/mongoose.exe -OutFile mongoose.exe
write-host "The webserver will listen on these ip's on port 8000, change Linux script to match"
Get-NetIPAddress | Where-Object {$_.AddressFamily -eq "IPv4"} | Select-Object IPAddress
.\mongoose.exe
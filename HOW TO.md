# 1. How to install
1. Create an Ubuntu 22.10 VM

Optional: Enable Enhanced Session Mode for the Ubuntu VM. This is required for the clipboard to work.
```powershell
Set-VM -VMName <your_vm_name> -EnhancedSessionTransportType HvSocket
```
2. Download the **run-first-on-windows.ps1** script
3. Modify the settings in the script to match your environment
4. Run the script, preferably line by line, to make sure you understand what it does.
5. Switch to the Ubuntu VM (I prefer via putty)
6. Download the **1-ubuntu.sh** script and run it. This is mainly to install the required packages, desktop env and some HyperV stuff. Modify it for your own needs.
```bash
wget https://raw.githubusercontent.com/SShadowS/BC4Ubuntu/main/scripts/1-ubuntu.sh
nano 1-ubuntu.sh
sudo bash 1-ubuntu.sh
```
7. A reboot of the VM is required. (Should be triggered by the script.)
8. Run install.sh (HyperV nicety stuff, skip if not needed.)
```bash
sudo ./install.sh
```
9. A reboot of the VM is required. (Only if you did step 7.)
10. Copy/paste the lines one by one from the **2-ubuntu.sh** script and run them in the Ubuntu VM. (**Modify** it to match your environment.) *Hope to automate this in the future.*

11. Prepare the WINEPREFIX by running winetricks and create a new WINEPREFIX (ARCH=64,Name=bc1). Just accept any prompts and exit winetricks afterwards. Then run the following commands:

```bash
winetricks prefix=bc1 -q dotnet48
winetricks prefix=bc1 -q dotnetdesktop6

7z e Chocolatey-for-wine.7z
cd Chocolatey-for-wine
WINEPREFIX=~/.local/share/wineprefixes/bc1 wine ChoCinstaller_0.5q.703.exe

cp secret.key  ~/.local/share/wineprefixes/bc1/drive_c/Program\ Files/Microsoft\ Dynamics\ NAV/230/Service/Secret.key
cp secret.key  ~/.local/share/wineprefixes/bc1/drive_c/ProgramData/Microsoft/Microsoft\ Dynamics\ NAV/230/Server/Keys/bc.key
cp secret.key  ~/.local/share/wineprefixes/bc1/drive_c/ProgramData/Microsoft/Microsoft\ Dynamics\ NAV/230/Server/Keys/BusinessCentral220.key

```

12.    Install Powershell 5.1
```bash
WINEPREFIX=~/.local/share/wineprefixes/bc1 wine powershell
```
 - Type **winetricks ps51** in the powershell core prompt and press enter.
  
13.   Exit the powershell core prompt
14.    Install Asp Core and the Service Tier
```bash
WINEPREFIX=~/.local/share/wineprefixes/bc1 wine uninstaller
```
- Press **Install...** and install the Asp Core and Service Tier installers. The installers are located in the folder where you downloaded the run-first-on-ubuntu.sh script. The installers are named "dotnet-hosting-6.0.14-win.exe" and "Microsoft Dynamics 365 Business Central Server.msi". The order is important. The Asp Core must be installed first.

15. Edit the CustomSettings.config file and change the following lines to false to disable the services:
```xml
<add key="ManagementServicesEnabled" value="true" />
<add key="ManagementApiServicesEnabled" value="true" />
<add key="ClientServicesEnabled" value="true" />
<add key="DeveloperServicesEnabled" value="true" />
<add key="SnapshotDebuggerEnabled" value="true" />
<add key="SOAPServicesEnabled" value="true" />
<add key="ODataServicesEnabled" value="true" />
<add key="ODataServicesV4EndpointEnabled" value="true" />
<add key="ApiServicesEnabled" value="True" />
```
16.    Copy the CustomSettings.config file to the Service Tier folder
```bash
cp ~/CustomSettings.config ~/.local/share/wineprefixes/bc1/drive_c/Program\ Files/Microsoft\ Dynamics\ NAV/230/Service/
```

17.    Start the Service Tier
```bash
WINEPREFIX=~/.local/share/wineprefixes/bc1 /opt/wine-staging/bin/wine cmd
```

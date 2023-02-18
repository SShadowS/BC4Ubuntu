# How to install
1. Create an Ubuntu 22.10 VM
The following enables Enhanced Session Mode for the Ubuntu VM. This is required for the clipboard to work.
```powershell
Set-VM -VMName <your_vm_name> -EnhancedSessionTransportType HvSocket
```

2. Download the **run-first-on-windows.ps1** script

3. Modify the settings in the script to match your environment

4. Run the script

5. Switch to the Ubuntu VM 

6. Download the **run-first-on-ubuntu.sh** script, modify the settings in the script to match your environment and run it. The script will install the required packages and download the required files. Just accept the defaults when prompted.
```bash
wget https://raw.githubusercontent.com/SShadowS/BC4Ubuntu/main/scripts//run-first-on-ubuntu.sh
nano run-first-on-ubuntu.sh
sudo bash run-first-on-ubuntu.sh
```
7. A reboot of the VM is required.

8. Install Powershell 5.1
```bash
wine powershell
```
 - Type **ps51** in the powershell core prompt and press enter.
9. Exit the powershell core prompt

10. Install Asp Core and the Service Tier
```bash
WINEPREFIX=~/.local/share/wineprefixes/bc1 wine uninstaller
```
- Press **Install...** and then select the Asp Core and Service Tier installers. The installers are located in the folder where you downloaded the run-first-on-ubuntu.sh script. The installers are named "dotnet-hosting-6.0.14-win.exe" and "Microsoft Dynamics 365 Business Central Server.msi". The order is important. The Asp Core must be installed first.

11. Import encryption key
```bash
WINEPREFIX=~/.local/share/wineprefixes/bc1 wine powershell
```
- Type **ps51** in the powershell core prompt and press enter.
- Change to the Service Tier folder and import NavAdminTool.ps1
```powershell
c:
cd '\Program Files\Microsoft Dynamics NAV\220\Service'
Import-Module .\NavAdminTool.ps1
```

12. Copy the CustomSettings.config file to the Service Tier folder
```bash
cp ~/CustomSettings.config ~/.local/share/wineprefixes/bc1/drive_c/Program\ Files/Microsoft\ Dynamics\ NAV/220/Service/
```

13. Start the Service Tier
```bash
WINEPREFIX=~/.local/share/wineprefixes/bc1 /opt/wine-staging/bin/wine cmd
```

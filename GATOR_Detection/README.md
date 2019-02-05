Ran into an interesting issue where findings for a particular Nessus plugin were showing up for a small number of hosts.

We were unable to determine exactly why as there was no useful data in the plugin output. After reverse engineering the NASL script and essentially recreating it in PowerShell, we were able to see what the plugin was potentially flagging on (if anything) and then remediate or close out as false-positive.

See the included analysis (PDF) for more information.

<br/>

#### Instructions:
You'll need to use `Set-ExecutionPolicy` to allow the script to run. More info [here](https://technet.microsoft.com/en-us/library/ee176961.aspx).

 1. Run PowerShell as Administrator
 2. Issue this command: `Set-ExecutionPolicy Unrestricted`
 3. Run the script: `.\gator_detection.ps1`
 4. When finished, you can set the execution policy back: `Set-ExecutionPolicy Restricted`

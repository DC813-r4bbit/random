#requires -version 4
##################################################################################################################################
##  [REDACTED] Information Security
##################################################################################################################################
##  [REDACTED] Medium Vulnerability: GATOR Detection (11998)
##       DATE: 08/23/2017
##################################################################################################################################
<#
    .NAME
        GATOR Detection

    .SYNOPSIS
        Searches Windows registry for signs of GATOR spyware/adware.

    .DESCRIPTION
        This script will search the registry of the local machine for specific keys that would indicate the presense of 
        GATOR; a known spyware/malware application. The key paths used in this check were pulled from the NASL script
        for Nessus plugin 11998. 
        
        Reference(s): 
            - Link: https://www.tenable.com/plugins/index.php?view=single&id=11998
            - Path: /opt/nessus/lib/nessus/plugins/
            - File: gator_detection.nasl

    .PARAMETER
        (none)

    .INPUTS
        (none)

    .OUTPUTS
        (none)

    .NOTES
        File Name:      gator_detection.ps1
        Version:        1.0
        Author:         Brian Etchieson
        Creation Date:  AUG/24/2017
        Purpose/Change: Initial script development

    .EXAMPLE
        .\gator_detection.ps1
#>

#-------------------------------------------------------[Script Parameters]-------------------------------------------------------

Param (
    #Script parameters go here
)

#--------------------------------------------------------[Initialisations]--------------------------------------------------------

#Set Error Action to Silently Continue
$ErrorActionPreference = 'SilentlyContinue'

#Import Modules & Snap-ins

#----------------------------------------------------------[Declarations]---------------------------------------------------------

#Script Version
$sScriptVersion = '1.0'

#Key paths from gator_detection.nasl
$RegKeys = @(
    @{ 'Path' = 'HKLM:\software\classes\interface\{06dfeda9-6196-11d5-bfc8-00508b4a487d}' }
    @{ 'Path' = 'HKLM:\software\classes\interface\{38493f7f-2922-4c6c-9a9a-8da2c940d0ee}' }
    @{ 'Path' = 'HKLM:\software\classes\kbbar.kbbarband\clsid' }
    @{ 'Path' = 'HKLM:\software\gatortest' }
    @{ 'Path' = 'HKLM:\software\microsoft\windows\currentversion\stashedgef' }
    @{ 'Path' = 'HKLM:\software\microsoft\windows\currentversion\app management\arpcache\gator' }
    @{ 'Path' = 'HKLM:\software\microsoft\windows\currentversion\run\trickler' }
    @{ 'Path' = 'HKLM:\software\microsoft\windows\currentversion\uninstall\gator' }
    @{ 'Path' = 'HKLM:\software\microsoft\windows\currentversion\uninstall\{456ba350-947f-4406-b091-aa1c6678ebe7}' }
    @{ 'Path' = 'HKLM:\software\microsoft\windows\currentversion\uninstall\{6c8dbec0-8052-11d5-a9d5-00500413153c}' }
)

#Checks/results tracking
$RequiredSuccessfulChecks = $RegKeys.Count
$ChecksPassed = 0

#-----------------------------------------------------------[Functions]-----------------------------------------------------------

Function detect-Gator {
    Write-Host ' '
    $RegKeys | foreach {
        $Query = Test-Path $_.Path
        if ($Query) {
            Write-Host -ForegroundColor Red "   FOUND: '$($_.Path)'"
        } else {
            Write-Host -ForegroundColor Green "   Not found: '$($_.Path)'"
            $ChecksPassed++
        }
    }
    if ($RequiredSuccessfulChecks -eq $ChecksPassed) {
        Write-Host -ForegroundColor White -BackgroundColor DarkGreen "`n No registry keys were found "
        #$true
    } else {
        Write-Host -ForegroundColor White -BackgroundColor DarkRed "`n $($RequiredSuccessfulChecks - $ChecksPassed) out of $($RequiredSuccessfulChecks) registry keys were found "
        #$false
    }
}

#-----------------------------------------------------------[Execution]-----------------------------------------------------------

detect-Gator


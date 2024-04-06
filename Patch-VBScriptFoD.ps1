<#
.SYNOPSIS
    This script is used to patch the VBScriptFoD package to allow it to be installed on Windows Server 2019.

.DESCRIPTION
    This script is used to patch the VBScriptFoD package to allow it to be installed on Windows Server 2019.

.Author
    Simon Lee
    @smoon_lee

.Change Log
    2024-04-06 : v1.0 - Initial release.

#>

#Requires -RunAsAdministrator

# Verbose 
Write-Output "--------------------------------------------"
Write-Output " VBScript Patch for ADK ADK 10.1.25398.1    "
Write-Output "--------------------------------------------"

$sourceFolder = "$PSScriptRoot\iso_files"

#
$FoDFiles = Get-ChildItem -Path $sourceFolder | Where-Object { $_.Name -notlike '*en-*' }
$FoDLangFiles = Get-ChildItem -Path $sourceFolder | Where-Object { $_.Name -like '*en-*' }

forEach ($FoD in $FoDFiles) {
    Write-Output "Coping [$FoD.Name] to Windows Preinstallation Environment\amd64\WinPE_OCs"
    Copy-Item -Path $FoD.FullName -Destination "${Env:ProgramFiles(x86)}\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs" -Force
}

Write-Output '' # Verbose Script Spacing 
forEach ($FoDLang in $FoDLangFiles) {
    Write-Output "Coping [$FoDLang.Name] to Windows Preinstallation Environment\amd64\WinPE_OCs\en-us"
    Copy-Item -Path $FoDLang.FullName -Destination "${Env:ProgramFiles(x86)}\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us" -Force
}

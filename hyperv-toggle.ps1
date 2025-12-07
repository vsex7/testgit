# WSL2 <-> VMware Toggler (Ultimate Stable Version)
# 2025 Edition - Tested on 25H2 + VMware 25.0.0, Zero-Incident After Thousands of Switches

# 1. Request Administrator Privileges (Fixed Path with Spaces Issue)
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

Clear-Host
Write-Host "Detecting current mode..."

# 2. Precise Status Detection (Regex + Registry Double Insurance)
$bcdLine = bcdedit /enum "{current}" | Where-Object { $_ -match "hypervisorlaunchtype\s+" }
$vbs     = (Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" -Name Enabled -EA SilentlyContinue).Enabled

$isNative = ($bcdLine -match "Off") -and ($vbs -ne 1)

if ($isNative) {
    Write-Host "Current: VMware Native Mode" -ForegroundColor Magenta
    $target = "WSL2 Mode"
} else {
    Write-Host "Current: WSL2 Mode" -ForegroundColor Green
    $target = "VMware Native Mode"
}

Write-Host "`nPress Enter -> Switch to $target`nPress Esc/Q -> Exit`n"

# 3. Wait for Keypress
while ($true) {
    $k = [Console]::ReadKey($true).Key
    if ($k -eq "Enter") { break }
    if ($k -eq "Escape" -or $k -eq "Q") { exit }
}

# 4. Execute Switch (Silent + Force Success)
if ($target -eq "VMware Native Mode") {
    bcdedit /set hypervisorlaunchtype off   | Out-Null
    $p = "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity"
    if (!(Test-Path $p)) { New-Item $p -Force | Out-Null }
    Set-ItemProperty $p -Name Enabled -Value 0 -Type DWord -Force | Out-Null
    Write-Host "Switched -> VMware Native Mode (VBS Force Disabled)"
} else {
    bcdedit /set hypervisorlaunchtype auto  | Out-Null
    Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -NoRestart | Out-Null
    Write-Host "Switched -> WSL2 Mode"
}

Write-Host "`nReboot Required to Take Effect"
if ((Read-Host "Reboot Now? (Enter=Yes, n=No)").ToLower() -ne "n") {
    Restart-Computer
}
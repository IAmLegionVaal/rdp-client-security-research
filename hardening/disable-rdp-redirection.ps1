#Requires -RunAsAdministrator
[CmdletBinding(SupportsShouldProcess)]
param(
    [switch]$DisableClipboard = $true,
    [switch]$DisableDrive = $true,
    [switch]$DisablePrinter = $true,
    [switch]$DisablePnP = $true
)

$ErrorActionPreference = 'Stop'
$policyPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services'

try {
    if (-not (Test-Path -Path $policyPath)) {
        New-Item -Path $policyPath -Force | Out-Null
    }

    $settings = @{}
    if ($DisableClipboard) { $settings['fDisableClip'] = 1 }
    if ($DisableDrive)     { $settings['fDisableCdm'] = 1 }
    if ($DisablePrinter)   { $settings['fDisableCpm'] = 1 }
    if ($DisablePnP)       { $settings['fDisablePNPRedir'] = 1 }

    foreach ($name in $settings.Keys) {
        if ($PSCmdlet.ShouldProcess($policyPath, "Set $name=$($settings[$name])")) {
            New-ItemProperty -Path $policyPath -Name $name -Value $settings[$name] -PropertyType DWord -Force | Out-Null
        }
    }

    Write-Host 'RDP redirection hardening policy applied. Run gpupdate /force or reboot for full effect.'
}
catch {
    Write-Error "Failed to apply RDP hardening policy: $($_.Exception.Message)"
    exit 1
}

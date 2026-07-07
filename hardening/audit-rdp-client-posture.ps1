#Requires -Version 5.1
[CmdletBinding()]
param(
    [string]$OutputPath = ".\rdp-client-posture.json"
)

$ErrorActionPreference = 'Stop'

function Get-RegistryDword {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)] [string]$Path,
        [Parameter(Mandatory)] [string]$Name
    )

    try {
        $item = Get-ItemProperty -Path $Path -Name $Name -ErrorAction Stop
        return [int]$item.$Name
    }
    catch {
        return $null
    }
}

function Test-RdpPolicyState {
    [CmdletBinding()]
    param()

    $policyPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services'

    [pscustomobject]@{
        PolicyPath                  = $policyPath
        DisableClipboardRedirection = Get-RegistryDword -Path $policyPath -Name 'fDisableClip'
        DisableDriveRedirection     = Get-RegistryDword -Path $policyPath -Name 'fDisableCdm'
        DisablePrinterRedirection   = Get-RegistryDword -Path $policyPath -Name 'fDisableCpm'
        DisablePnPRedirection       = Get-RegistryDword -Path $policyPath -Name 'fDisablePNPRedir'
    }
}

function Get-RdpClientEvidence {
    [CmdletBinding()]
    param()

    $mstsc = Get-Command mstsc.exe -ErrorAction SilentlyContinue
    $rdpProcesses = Get-Process -Name mstsc, rdpclip -ErrorAction SilentlyContinue | Select-Object Name, Id, Path, StartTime

    [pscustomobject]@{
        ComputerName        = $env:COMPUTERNAME
        UserName            = $env:USERNAME
        TimestampUtc        = (Get-Date).ToUniversalTime().ToString('o')
        MstscPath           = $mstsc.Source
        ActiveRdpProcesses  = $rdpProcesses
        PolicyState         = Test-RdpPolicyState
    }
}

try {
    $evidence = Get-RdpClientEvidence
    $json = $evidence | ConvertTo-Json -Depth 6
    $json | Out-File -FilePath $OutputPath -Encoding utf8 -Force
    Write-Host "RDP client posture written to: $OutputPath"
    $evidence
}
catch {
    Write-Error "RDP posture audit failed: $($_.Exception.Message)"
    exit 1
}

#Requires -Version 5.1
[CmdletBinding()]
param(
    [int]$HoursBack = 24,
    [string]$OutputPath = ".\rdp-timeline.csv"
)

$ErrorActionPreference = 'Stop'

$startTime = (Get-Date).AddHours(-1 * [math]::Abs($HoursBack))

$eventQueries = @(
    @{ LogName = 'Microsoft-Windows-TerminalServices-ClientActiveXCore/Operational'; Id = @(1024, 1025, 1102) },
    @{ LogName = 'Microsoft-Windows-TerminalServices-RDPClient/Operational'; Id = @(1024, 1026, 1027, 1028) },
    @{ LogName = 'Security'; Id = @(4688) }
)

$timeline = foreach ($query in $eventQueries) {
    try {
        Get-WinEvent -FilterHashtable @{
            LogName   = $query.LogName
            Id        = $query.Id
            StartTime = $startTime
        } -ErrorAction Stop | ForEach-Object {
            [pscustomobject]@{
                TimeCreated = $_.TimeCreated
                LogName     = $_.LogName
                EventId     = $_.Id
                Provider    = $_.ProviderName
                Message     = ($_.Message -replace "`r|`n", ' ')
            }
        }
    }
    catch {
        Write-Warning "Could not query $($query.LogName): $($_.Exception.Message)"
    }
}

try {
    $timeline | Sort-Object TimeCreated | Export-Csv -Path $OutputPath -NoTypeInformation -Encoding UTF8
    Write-Host "RDP timeline exported to: $OutputPath"
    $timeline | Sort-Object TimeCreated | Select-Object -First 20
}
catch {
    Write-Error "Failed to export RDP timeline: $($_.Exception.Message)"
    exit 1
}

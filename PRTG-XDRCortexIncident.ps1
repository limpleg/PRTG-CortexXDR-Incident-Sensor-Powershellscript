<#
    .SYNOPSIS
    PRTG Advanced Sensor - Cortex XDR Incidents
  
    .DESCRIPTION
    This Advanced Sensor will monitor and report Cortex XDR Incidents
        
    .EXAMPLE
    PRTG-XDRCortexIncident.ps1
    .Notes
    NAME:  PRTG-XDRCortexIncident.ps1
    AUTHOR: Daniel Weber
    LASTEDIT: 04.07.2025
    VERSION: 1.0
    KEYWORDS: PRTG, Cortex XDR
#>
# set PRTG Parameters
 
 param (
    [string]$APIID = $(throw "<prtg><error>1</error><text>-API ID is missing in parameters</text></prtg>"),
    [string]$APIKey = $(throw "<prtg><error>1</error><text>-API Key is missing in parameters</text></prtg>"),
    [string]$Region = $(throw "<prtg><error>1</error><text>-API Key is missing in parameters</text></prtg>"),
    [string]$tenant = $(throw "<prtg><error>1</error><text>-Tenant is missing in parameters</text></prtg>")
)

#Import PS Module written by https://github.com/lahell/PSCortex?tab=readme-ov-file
try {
    Import-Module "PSCortex" -ErrorAction Stop
}
catch {
    Write-Output "<prtg>"
    Write-Output " <error>1</error>"
    Write-Output " <text>Error Loading PSCortex Powershell Module ($($_.Exception.Message))</text>"
    Write-Output "</prtg>"
    Exit
}

# Convert password to SecureString
$secureKey = ConvertTo-SecureString $APIKey -AsPlainText -Force

# Create PSCredential object
$Credential = New-Object System.Management.Automation.PSCredential ($APIID, $secureKey)

Initialize-CortexConfig -TenantName $tenant -SecurityLevel Advanced -Region $Region -Credential $Credential

# Get Count of Incident Status
$NewIncident = (Get-CortexIncident -Status New).Count
$ResolvedAuto = (Get-CortexIncident -Status ResolvedAuto).Count
$ResolvedDuplicate = (Get-CortexIncident -Status ResolvedDuplicate).Count
$ResolvedFalsePositive = (Get-CortexIncident -Status ResolvedFalsePositive).Count
$ResolvedKnownIssue = (Get-CortexIncident -Status ResolvedKnownIssue).Count
$ResolvedOther = (Get-CortexIncident -Status ResolvedOther).Count
$ResolvedThreadHandled = (Get-CortexIncident -Status ResolvedThreatHandled).Count
$UnderInvestigation = (Get-CortexIncident -Status UnderInvestigation).Count

#Store XML Output
$xmlOutput = '<prtg>'
$xmlOutput = $xmlOutput + "<result>
        <channel>New Incident</channel>
        <value>$($NewIncident)</value>
        <unit>Count</unit>
        </result>
        <result>
        <channel>Resolved Automatically</channel>
        <value>$($ResolvedAuto)</value>
        <unit>Count</unit>
        </result>
                <result>
        <channel>Resolved Duplicates</channel>
        <value>$($ResolvedDuplicate)</value>
        <unit>Count</unit>
        </result>
                <result>
        <channel>Resolved False Positive</channel>
        <value>$($ResolvedFalsePositive)</value>
        <unit>Count</unit>
        </result>
                <result>
        <channel>Resolved Known Issues</channel>
        <value>$($ResolvedKnownIssue)</value>
        <unit>Count</unit>
        </result>
                <result>
        <channel>Resolved Others</channel>
        <value>$($ResolvedOther)</value>
        <unit>Count</unit>
        </result>
                <result>
        <channel>Resolved Handled by Threat</channel>
        <value>$($ResolvedThreadHandled)</value>
        <unit>Count</unit>
        </result>
                <result>
        <channel>Under Investigation</channel>
        <value>$($UnderInvestigation)</value>
        <unit>Count</unit>
        </result>"

$xmlOutput = $xmlOutput + "</prtg>"

Write-Output $xmlOutput

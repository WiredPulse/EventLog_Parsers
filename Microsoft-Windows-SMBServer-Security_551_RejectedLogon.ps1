# Filters for events where this system attempted to connect to another system via insecure guest logon, which was rejected

[CmdletBinding()]
param(
    [parameter(ParameterSetName="set1")] [switch]$Live,
    [parameter(ParameterSetName="set2")] [switch]$Offline,
    [parameter(ParameterSetName="set2", Mandatory=$true)] $Path
)

if($live){
    $evts = Get-WinEvent -FilterHashtable @{logname="Microsoft-Windows-Smbserver/security";id="551"}
}
else{
    $evts = Get-WinEvent -FilterHashtable @{path="$path";id="551"}
}

$evts | Select-Object timecreated, 
    @{Label="Process";Expression={$_.properties.value[9..12]}}, 
    @{Label="ClientAddress";Expression={$_.properties.value[25]}}, 
    @{Label="UserName";Expression={$_.properties.value[23]}} | Format-Table

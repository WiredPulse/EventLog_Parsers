[CmdletBinding()]
param(
    [parameter(ParameterSetName="set1")] [switch]$Live,
    [parameter(ParameterSetName="set2")] [switch]$Offline,
    [parameter(ParameterSetName="set2", Mandatory=$true)] $Path
)

if($live){
    $evts = Get-WinEvent -FilterHashtable @{logname="Microsoft-Windows-DNS-Client/Operational";id="3006"}
}
elseif($offline){
    $evts = Get-WinEvent -FilterHashtable @{path="$path";id="3006"}
}

$evts | Select-Object timecreated, 
    @{Label="QueryName";Expression={$_.properties.value[0]}}, 
    @{Label="QueryType";Expression={$_.properties.value[1]}}, 
    @{Label="QueryOptions";Expression={$_.properties.value[2]}}, 
    @{Label="ServerList";Expression={$_.properties.value[3]}}, 
    @{Label="IsNetworkQuery";Expression={$_.properties.value[4]}}, 
    @{Label="NetworkQueryIndexy";Expression={$_.properties.value[5]}}, 
    @{Label="InterfaceIndex";Expression={$_.properties.value[6]}}, 
    @{Label="IsAsyncQuery";Expression={$_.properties.value[7]}} | Format-Table


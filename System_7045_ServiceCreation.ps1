[CmdletBinding()]
param(
    [parameter(ParameterSetName="set1")] [switch]$Live,
    [parameter(ParameterSetName="set2")] [switch]$Offline,
    [parameter(ParameterSetName="set2", Mandatory=$true)] $Path
)

if($live){
    $evts = Get-WinEvent -FilterHashtable @{logname="system";id="7045"}
}
else{
    $evts = Get-WinEvent -FilterHashtable @{path="$path";id="7045"}
}

$evts | Select-Object timecreated, 
    ProcessID,
    SID,
    @{Label="ServiceName";Expression={$_.properties.value[0]}}, 
    @{Label="ServiceFileName";Expression={$_.properties.value[1]}}, 
    @{Label="ServiceType";Expression={$_.properties.value[2]}}, 
    @{Label="ServiceStartupType";Expression={$_.properties.value[3]}}, 
    @{Label="ServiceAccount";Expression={$_.properties.value[4]}} | ogv


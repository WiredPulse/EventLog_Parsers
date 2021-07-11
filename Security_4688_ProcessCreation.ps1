[CmdletBinding()]
param(
    [parameter(ParameterSetName="set1")] [switch]$Live,
    [parameter(ParameterSetName="set2")] [switch]$Offline,
    [parameter(ParameterSetName="set2", Mandatory=$true)] $Path
)

if($live){
    $evts = Get-WinEvent -FilterHashtable @{logname="security";id="4688"}
}
else{
    $evts = Get-WinEvent -FilterHashtable @{path="$path";id="4688"}
}

$evts | Select-Object timecreated, 
    @{Label="Account";Expression={$_.properties.value[1]}}, 
    @{Label="LogonID";Expression={$_.properties.value[3]}}, 
    @{Label="TargetAccount";Expression={$_.properties.value[10]}}, 
    @{Label="TargetLogonID";Expression={$_.properties.value[12]}}, 
    @{Label="PID";Expression={$_.properties.value[4]}}, 
    @{Label="Process";Expression={$_.properties.value[5]}}, 
    @{Label="Commandline";Expression={$_.properties.value[8]}},
    @{Label="ParentPID";Expression={$_.properties.value[7]}},  
    @{Label="ParentProcess";Expression={$_.properties.value[13]}} | Format-Table


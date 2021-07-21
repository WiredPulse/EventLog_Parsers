[CmdletBinding()]
param(
    [parameter(ParameterSetName="set1")] [switch]$Live,
    [parameter(ParameterSetName="set2")] [switch]$Offline,
    [parameter(ParameterSetName="set2", Mandatory=$true)] $Path
)

if($live){
    $evts = Get-WinEvent -FilterHashtable @{logname="security";id="4616"}
}
else{
    $evts = Get-WinEvent -FilterHashtable @{path="$path";id="4616"}
}

$evts | Select-Object timecreated, 
    @{Label="UserSID";Expression={$_.properties.value[0]}}, 
    @{Label="UserName";Expression={$_.properties.value[1]}}, 
    @{Label="DomainName";Expression={$_.properties.value[2]}}, 
    @{Label="PreviousTime";Expression={$_.properties.value[4]}}, 
    @{Label="NewTime";Expression={$_.properties.value[5]}}, 
    @{Label="ProcessID";Expression={$_.properties.value[6]}}, 
    @{Label="ProcessName";Expression={$_.properties.value[7]}}| Format-Table

   
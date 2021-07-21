[CmdletBinding()]
param(
    [parameter(ParameterSetName="set1")] [switch]$Live,
    [parameter(ParameterSetName="set2")] [switch]$Offline,
    [parameter(ParameterSetName="set2", Mandatory=$true)] $Path
)

if($live){
    $evts = Get-WinEvent -FilterHashtable @{logname="security";id="4647"}
}
else{
    $evts = Get-WinEvent -FilterHashtable @{path="$path";id="4647"}
}

$evts | Select-Object timecreated, 
    @{Label="UserSID";Expression={$_.properties.value[0]}}, 
    @{Label="UserName";Expression={$_.properties.value[1]}}, 
    @{Label="DomainName";Expression={$_.properties.value[2]}} | Format-Table

   
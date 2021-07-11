Get-WinEvent -FilterHashtable @{logname='security';id='4688'} |
Select-Object timecreated, 
    @{Label="Account";Expression={$_.properties.value[1]}}, 
    @{Label="Logon ID";Expression={$_.properties.value[3]}}, 
    @{Label="Target Account";Expression={$_.properties.value[10]}}, 
    @{Label="Target Logon ID";Expression={$_.properties.value[12]}}, 
    @{Label="PID";Expression={$_.properties.value[4]}}, 
    @{Label="Process";Expression={$_.properties.value[5]}}, 
    @{Label="Commandline";Expression={$_.properties.value[8]}},
    @{Label="Parent PID";Expression={$_.properties.value[7]}},  
    @{Label="Parent Process";Expression={$_.properties.value[13]}} | Format-Table


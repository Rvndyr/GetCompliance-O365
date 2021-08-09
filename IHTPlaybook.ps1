#####
# Created by: Randy Rodriguez
#####
param(
   [Parameter()]
   [string]$email
)
 
write-host "Entered Email:" $email
 
write-host "Connecting to Exchange online Powershell Session"
Connect-exopssession -userprincipalname $email
write-host "Importing Module MSOnline"
Import-Module MSOnline
write-host "Connecting to MSOLService"
Connect-MSOLService
write-host "Connecting IPPSSession"
Connect-IPPSSession -UserPrincipalName $email -ConnectionUri https://ps.compliance.protection.outlook.com/powershell-liveid/ 
 
$a = $(get-date).AddDays(-7)
$searchName = Get-ComplianceSearchAction | where { $_.JobStartTime -gt $a } | convertTo-Json
$outPutList = Get-ComplianceSearchAction | where { $_.JobStartTime -gt $a } | ft searchName
 
Start-Sleep -Seconds 3
$searchNameObj = ConvertFrom-Json -InputObject $searchName
#$outPutList
 
[System.Console]::Clear()
write-host "Jobs ran in the last 7 days:"
for ($num = 0 ; $num -le ($SearchNameObj.Count - 1) ; $num++) { 
   write-host $num $SearchNameObj[$num].SearchName
}
 
$inputNum = Read-host -Prompt "Select the O365 job to purge from the above list (eg.Enter a number:0, 1, 2, 3)"
 
$selectedSearch = $searchNameObj[$inputNum].searchName
$selectedSearch
 
New-ComplianceSearchAction -SearchName $selectedSearch -preview
write-host "Ready to process purging emails from job $selectedSearch.  Continue (y/n)?"
$User = Read-Host -Prompt ' '
if ( $User -eq "y" -and $User -eq "Y" ) {
   New-ComplianceSearchAction -SearchName $selectedSearch -Purge -PurgeType SoftDelete
   
}
else {
   write-host "Stopping"
   exit
}
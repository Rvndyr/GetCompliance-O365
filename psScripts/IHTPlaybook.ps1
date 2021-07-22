#####
# Created by: Randy Rodriguez
#####
param(
     [Parameter()]
     [string]$email
)
 
write-host "My email is:" $email
 
write-host "Connecting to Exchange online Powershell Session"
Connect-exopssession -userprincipalname $email
write-host "Importing Module MSOnline"
Import-Module MSOnline
write-host "Connecting to MSOLService"
Connect-MSOLService
write-host "Connecting IPPSSession"
Connect-IPPSSession -UserPrincipalName $email -ConnectionUri https://ps.compliance.protection.outlook.com/powershell-liveid/ 
 
$a = $(get-date).AddDays(-2)
$searchName = Get-ComplianceSearchAction | where { $_.JobStartTime -gt $a } | convertTo-Json
$outPutList =  Get-ComplianceSearchAction | where { $_.JobStartTime -gt $a } | ft searchName
 
Start-Sleep -Seconds 3
$searchNameObj = ConvertFrom-Json -InputObject $searchName
#$outPutList
 
for ($num = 0 ; $num -le 5 ; $num++){    $SearchNameObj[$num].SearchName}
 
$inputNum = Read-host -Prompt "Which one to purge from the above list (eg. type in a NUMBER: 1, 2, 3, etc)"
if ( $inputNum -eq 1 )
{
   $inputNum = 0
}
if ( $inputNum -eq 2 )
{
   $inputNum = 1
}
if ( $inputNum -eq 3 )
{
   $inputNum = 2
}
if ( $inputNum -eq 4 )
{
   $inputNum = 3
}
if ( $inputNum -eq 4 )
{
   $inputNum = 4
}
$selectedSearch = $searchNameObj[$inputNum].searchName
$selectedSearch
 
 
# New-ComplianceSearchAction -SearchName "yoursearchname" -preview
# New-ComplianceSearchAction -SearchName "yoursearchname" -Purge -PurgeType SoftDelete 
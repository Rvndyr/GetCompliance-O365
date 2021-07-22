param(
     [Parameter()]
     [string]$email
)

write-host "My email is:" $email

write-host "Connecting to Exchange online Powershell Session"
Connect-exopssession -userprincipalname $email 
write-host "Importing Module MSOnline"
Import-Module MSOnline
write-host "Connect to MSOLService (you may see a pop up, please ignore"
Connect-MSOLService 
write-host "Connect IPPSSession" 
Connect-IPPSSession -UserPrincipalName $email -ConnectionUri https://ps.compliance.protection.outlook.com/powershell-liveid/  
 
$a = $(get-date).AddDays(-2) 
$complicance_serach_action = Get-ComplianceSearchAction | where { $_.JobStartTime -gt $a } | ft Name, Status, JobStartTime, Runby, Searchname 
$complicance_serach_action
New-ComplianceSearchAction -SearchName "yoursearchname" -preview 
New-ComplianceSearchAction -SearchName "yoursearchname" -Purge -PurgeType SoftDelete  
 
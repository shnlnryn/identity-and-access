$header = @{
Authorization = "SSWS ###APIKEYHERE###"
Accept = "application/json"
'Content-Type' = "application/json"
}


$groupmembers = 'https://TENANT-admin.okta.com/api/v1/groups/###GROUPID###/users'


$Users= Invoke-RestMethod -Uri $groupmembers -Headers $header -Method GET -SslProtocol:Tls12 -FollowRelLink

$u = $Users.profile

$u | export-csv -Path /Users/####/users.export-csv

#if export-csv does not work, use below.
# $u | Out-File -FilePath d:\temp\exported.csv -NoClobber



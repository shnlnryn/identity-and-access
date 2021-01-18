$header = @{
Authorization = "SSWS ###APIKEY##"
Accept = "application/json"
'Content-Type' = "application/json"
}


$groupmembers = 'https://TENANT-admin.okta.com/api/v1/groups/###GROUPID###/users'


$GroupUsers= Invoke-RestMethod -Uri $groupmembers -Headers $header -Method GET -SslProtocol:Tls12 -FollowRelLink

$users = $GroupUsers.profile

$users | export-csv -Path /Users/myuser/Documents/groupUsers.csv

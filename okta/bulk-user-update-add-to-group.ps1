# This script can be used to bulk update user profile attribute and add them to a group.
# Credits to my good friend and powershell gangsta @adrwh (adrwh.github.io)

$header = @{
Authorization = "SSWS APIKEY"    ### Add your APIKey
Accept = "application/json"
'Content-Type' = "application/json"
}
$list = -split @"
user1@email.com
user2@email.com
user3@email.com
user4@email.com
"@
$list | ForEach-Object {
Write-Verbose -Verbose $_
try {
 $login = $_
 $uri = "https://org-admin.okta.com/api/v1/users/$login"      #### Add Okta Admin URL
 $r = Invoke-RestMethod -Uri $uri -Headers $header -Method Get -SslProtocol:Tls12
 $body = @{
 profile = @{
 Customattribute = "Value here". ##### update attribute with a static value
 }
 }
 | ConvertTo-Json
if ($r) {
 $id = $r.id
 $null = $r
 
 # Update the profile attribute zoomUserType
 $uri = "https://org-admin.okta.com/api/v1/users/$id"
 $r = Invoke-RestMethod -Uri $uri -Headers $header -Method Post -Body $body -SslProtocol:Tls12
 Start-Sleep -Seconds 3
 # # Add them to the okta group
 $uri = "https://org-admin.okta.com/api/v1/groups/GROUPID/users/$id"    ### Add GROUPID
 $r = Invoke-RestMethod -Uri $uri -Headers $header -Method Put -Body $body -SslProtocol:Tls12
}
 
}
catch {
 $_
}
$null = $r
}

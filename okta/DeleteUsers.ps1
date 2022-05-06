$config = Import-PowershellDataFile -Path ./config.psd1

$domain = $config.domain
$prodAPIkey = $config.oktaprodkey


$header = @{
Authorization = "SSWS " + $prodAPIkey
Accept = "application/json"
'Content-Type' = "application/json"
    }

$list = -split @"


email@email.com


"@
$list | ForEach-Object {
Write-Verbose -Verbose $_
try {
 $login = $_
 $uri = "https://$domain-admin.okta.com/api/v1/users/$login"
 $r = Invoke-RestMethod -Uri $uri -Headers $header -Method Get -SslProtocol:Tls12
 
if ($r) {
 $id = $r.id
 $null = $r
 
 # Delete User
 $uri = "https://$domain-admin.okta.com/api/v1/users/$id"
 $r = Invoke-RestMethod -Uri $uri -Headers $header -Method Delete -SslProtocol:Tls12
 
}
 
}
catch {
 $_
}
$null = $r
}

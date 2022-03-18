## Suspend user Okta account
$header = @{
Authorization = "SSWS APIKEY"    
Accept = "application/json"
'Content-Type' = "application/json"
}


$list = -split @"
test.user@domain.com
"@




$list | ForEach-Object {
Write-Verbose -Verbose $_
try {
 $login = $_
 $uri = "https://org-admin.okta.com/api/v1/users/$login"      
 $r = Invoke-RestMethod -Uri $uri -Headers $header -Method Get -SslProtocol:Tls12
 
if ($r) {
 $id = $r.id
 $null = $r


 
 #Suspend user
 $uri = "https://org-admin.okta.com/api/v1/users/$id/lifecycle/suspend"   #suspend user account


 $r = Invoke-RestMethod -Uri $uri -Headers $header -Method Post -SslProtocol:Tls12
 #Start-Sleep -Seconds 3


 
}
 
}
catch {
 $_
}
$null = $r
}


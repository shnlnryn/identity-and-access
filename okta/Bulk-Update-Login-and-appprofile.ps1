$header = @{
Authorization = "SSWS ***APIKEY****"
Accept = "application/json"
'Content-Type' = "application/json"
}

#Add list of user to bulk update. 
$list = -split @"

user@mydomain.com
"@
$list | ForEach-Object {
Write-Verbose -Verbose $_
try {
    

 $login = $_
#Replace email domain
 $u= $login.Split("@")[0]
 $newu= $u + "@newemaildomain.com"


$id + " " + $newu

# Email aliases for proxyaddress attribute
$smtp1 = "SMTP:" + $newu
$smtp2 = "smtp:" + $login

 # Update login and email in Provisioning app profile
$uri = "https://***tenant***-admin.okta.com/api/v1/users/$login"
$r = Invoke-RestMethod -Uri $uri -Headers $header -Method Get -SslProtocol:Tls12
 $body = @{
 profile = @{

    login =  $newu
    email = $newu
    proxyAddresses = @($smtp1, $smtp2)

 
 }
 
 }
 | ConvertTo-Json
if ($r) {
 $id = $r.id
 $null = $r
 

 $uri = "https://***tenant***-admin.okta.com/api/v1/users/$id"
 $r = Invoke-RestMethod -Uri $uri -Headers $header -Method Post -Body $body -SslProtocol:Tls12

 Write-Host "Prov app updated" -ForegroundColor Green
 
    }

#Update username in O365 SSO app profile
$SSOAppID = "****Add O365 SSO AppID " #SSO App ID


$Appuri = "https://**tenant***-admin.okta.com/api/v1/apps/$SSOAppID/users/$id"            
$a= Invoke-RestMethod -Uri $Appuri -Headers $header -Method Get -SslProtocol:Tls12



$body = @{
    credentials = @{
    
       userName=$newu
    
    }
    }
    | ConvertTo-Json
   if ($a) {
    $id = $a.id
    $null = $a
 
    $Appuri = "https://****tenant****-admin.okta.com/api/v1/apps/$SSOAppID/users/$id"
    $a = Invoke-RestMethod -Uri $Appuri -Headers $header -Method Post -Body $body -SslProtocol:Tls12

    Write-Host "O365 SSO app updated" -ForegroundColor Yellow
            }


#Update username in App2 profile
$AppID = "***APP2ID****" #App2 ID

            
$App2uri = "https://****tenant***-admin.okta.com/api/v1/apps/$AppID/users/$id"            
$a2= Invoke-RestMethod -Uri $Appuri -Headers $header -Method Get -SslProtocol:Tls12
            
            
    $body = @{
    credentials = @{
                
    userName=$newu
                
        }
        }
    | ConvertTo-Json
    if ($a2) {
                $id = $a2.id
                $null = $a2
             
                $Appuri = "https://***tenant***-admin.okta.com/api/v1/apps/$SSOAppID/users/$id"
                $a2 = Invoke-RestMethod -Uri $App2uri -Headers $header -Method Post -Body $body -SslProtocol:Tls12

                Write-Host "App updated" -ForegroundColor DarkMagenta
                Write-Host "************************" -ForegroundColor Yellow

                        }
             
    }



catch{
 $_
    }
$null = $r
}



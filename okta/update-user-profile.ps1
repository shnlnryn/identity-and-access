# Appply a static value in bulk to Okta user profiles.


$Header = @{
Authorization = "SSWS _API KEY HERE_"
Accept = "application/json"
}

$list = -split @"
user1@mydomain.com
user2@mydomain.com
user3@mydomain.com

"@



$list | For-Each-Object {

  Write-Verbose -Verbose $_
 
  try {
    ## Get Userid
   $login = $_
   $Uri = "https://company-admin.okta.com/api/v1/users/$login"
   $r = Invoke-RestMethod -Uri $Uri -Headers $Header -Method Get -SslProtocol:Tls12
   
   $body = @{
     Profile = {
       okta_user_attribute = "value_here"
                }
             }
             
   | ConvertTo-Json
   
   if ($r) {
   
   $Userid = $r.Userid
   $null = $r
   $Uri = "https://company-admin.okta.com/api/v1/users/$id"
   $r= Invoke-RestMethod -Uri $Uri -Headers $Header -Method POst -Body $body -SslProtocol:Tls12
   }
   
   Catch {
    $_
    }
   
   }
   
   

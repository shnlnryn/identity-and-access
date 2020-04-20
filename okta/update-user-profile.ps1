## Code in progress


$header = @{
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
  
   $login = $_
   $uri = "https://company-admin.okta.com/api/v1/users/$login"
   

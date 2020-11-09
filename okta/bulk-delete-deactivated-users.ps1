# Use TLS 1.2

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Setup Auth Header

$header = @{

 Authorization = "SSWS APIKEY_HERE"

}

$CSV=Import-csv -Path  "D:\temp\Deactivated-users.csv"



$CSV| ForEach-Object {

 $_.login

 $result = Invoke-WebRequest -Uri "https://ORG_HERE-admin.okta.com/api/v1/users/$($_.login)" -Headers $header -UseBasicParsing -method Delete

 $result.StatusCode

 $result.StatusDescription



}


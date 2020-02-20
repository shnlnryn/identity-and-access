
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$org = "######OKTATENANTID-admin.okta.com"  ####### Okta Org

$api_token = "#####Your Okta API KEY#####"  

#Change the path below to suit the resulting files location

$path = "d:\temp\US-Vol.csv"

$AllUsers = @()

$Headers = @{"Authorization" = "SSWS $api_token"; "Accept" = "application/json"; "Content-Type" = "application/json"}

$uri = "https://$org/api/v1/groups/####GROUP ID#####/users"  ######## GROUP ID

do {

  $WebResponse = Invoke-WebRequest -Headers $headers -Method Get -Uri $uri

  $Links = $WebResponse.Headers.Link.Split("<").Split(">") 

  $uri = $links[3]

  $users = $webresponse | ConvertFrom-Json

  $allusers += $users

} while ($webresponse.Headers.Link.EndsWith('rel="next"'))

$activeUsers = $allusers | Where-Object { $_.status -ne "DEPROVISIONED" }

$activeUsers | Select-Object -ExpandProperty profile | 

  Select-Object -Property login, firstName, lastName, title, city, department | 

  Export-Csv -Path $path -NoTypeInformation

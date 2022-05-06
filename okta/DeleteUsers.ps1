$config = Import-PowershellDataFile -Path ./config.psd1

$domain = $config.domain
$prodAPIkey = $config.oktaprodkey


$header = @{
Authorization = "SSWS " + $prodAPIkey
Accept = "application/json"
'Content-Type' = "application/json"
    }

$list = -split @"


andrea.kollberg@hillsong.com
Audrey.Whithorn@hillsong.com
billy.spriggs@hillsong.com
brandon.sampayan@hillsong.com
bridget.jentzsch@hillsong.com
bruce.friesen@hillsong.com
carol.stout@hillsong.com
charity.turner@hillsong.com
ct.hub@hillsong.com
ct.lasvegas@hillsong.com
ct.mesa@hillsong.com
ct.scottsdale@hillsong.com
daniel.tappero@hillsong.com
daniel.whithorn@hillsong.com
Doug.pouncey@hillsong.com
ebony.ramirez@hillsong.com
freddy.pabon@hillsong.com
glenda.miller@hillsong.com
greg.dille@hillsong.com
PHXaccounting@hillsong.com
isha.pabon@hillsong.com
jason.lliteras@hillsong.com
jennifer.garcia@hillsong.com
jeremy.boswell@hillsong.com
Jesse.Brown@volunteer.hillsong.com
jill.mclaughlin@hillsong.com
john.williams@hillsong.com
johnny.bettencourt@hillsong.com
joshua.crist@hillsong.com
judith.crist@hillsong.com
juliette.spurling@hillsong.com
karna.lliteras@hillsong.com
katie.odell@hillsong.com
kimberly.crist@hillsong.com
kimberly.wolf@hillsong.com
lexus.dudley@hillsong.com
lyn.vanommeren@hillsong.com
madison.butts@hillsong.com
marianne.cipolla@hillsong.com
matt.pugh@hillsong.com
melissa.hill@volunteer.hillsong.com
Mesa.Reception@hillsong.com
nate.wolf@hillsong.com
phoenix.comms@hillsong.com
phoenix.kids@hillsong.com
phxmiguser@hillsong.com
phxmigu@hillsong.com
phxmu@hillsong.com
phxyouth@hillsong.com
rachelle.green@volunteer.hillsong.com
randy.wolf@hillsong.com
rick.varner@hillsong.com
Sarah.Cordova-Bennett@hillsong.com
sarah.pugh@hillsong.com
sharon.corea@cityofgrace.com
sylvia.bruni@hillsong.com
terry.crist@hillsong.com
tommy.bachtle@hillsong.com
torryn.traxson@hillsong.com


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
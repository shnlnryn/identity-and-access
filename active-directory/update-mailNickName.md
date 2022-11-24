$OU = "ou=Users, OU=Students, OU=College, dc=domain, dc=domain, dc=net"
$Server = "domain.net"
$u=Get-ADUser -Filter * -SearchBase $OU -Properties * -Server $server |select userprincipalname, DistinguishedName


foreach ($user in $u){
$i =$user.userprincipalname
$d=$user.DistinguishedName
set-aduser $d -Server $Server -Replace @{mailNickname=$i}
}

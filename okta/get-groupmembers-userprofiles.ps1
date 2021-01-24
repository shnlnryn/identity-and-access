
$header = @{
Authorization = "SSWS ####API KEY###"
Accept = "application/json"
'Content-Type' = "application/json"
}

#Get group members
$groupmembers = 'https://###TENANT###-admin.okta.com/api/v1/groups/###GROUPID##/users'


$VUsers= Invoke-RestMethod -Uri $groupmembers -Headers $header -Method GET -SslProtocol:Tls12 -FollowRelLink

$users = $VUsers.profile



# Get User profiles to get lastlogon details
$users| ForEach-Object {
    

    $login= $_.login


    $u="https://###TENANT##-admin.okta.com/api/v1/users/$login"

    $uProf = Invoke-RestMethod -Uri $u -Headers $header -Method GET -SslProtocol:Tls12

    


    $report = [pscustomobject]@{
        id = $uProf.id
        firstName = $uProf.profile.firstName
        login = $uProf.profile.login
        created = $uProf.created
        lastlogin = $uProf.lastlogin
        status = $uProf.status
        }

        $report| Export-Csv -Append -path /users/shnl/documents/okta_Vol_users_report_$((get-date -Format "yyyyMMdd")).csv -NoTypeInformation -Force

}


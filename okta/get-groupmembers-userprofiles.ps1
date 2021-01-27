#This script gets members from a specified group and their user profile and MFA status.



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

    $uid = $uProf.id
    
# Get Factor status
    $factors="https://###TENANT###-admin.okta.com/api/v1/users/$uid/factors"
    $uf=Invoke-RestMethod -Uri $factors -Headers $header -Method GET -SslProtocol:Tls12

            $sms = $uf.where({$_.factorType -eq "sms"})
            $oktaverify = $uf.where({$_.factorType -eq "push"})
            $WebAuthn = $uf.where({$_.factorType -eq "webauthn"})
            $FIDO = $uf.where({$_.factorType -eq "token:hardware"})
            $OKTAOTP = $uf.where({$_.factorType -eq "token:software:totp"})

            


    #Create report and export
    $report = [pscustomobject]@{
        id = $uProf.id
        firstName = $uProf.profile.firstName
        login = $uProf.profile.login
        department=$uProf.profile.department
        manager=$uProf.profile.manager
        created = $uProf.created
        passwordChanged = $uprof.passwordChanged
        lastlogin = $uProf.lastlogin
        lastUpdated = $uProf.lastUpdated
        status = $uProf.status
        sms = $sms.status
        oktaverify= $oktaverify.status
        FIDO= $FIDO.status
        oktaotp=$OKTAOTP.status


        }

        $report| Export-Csv -Append -path /users/shnlnryn/documents/okta_Vol_users_report_$((get-date -Format "yyyyMMdd")).csv -NoTypeInformation -Force

}


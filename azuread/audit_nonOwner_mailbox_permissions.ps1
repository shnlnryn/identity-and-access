# Non Owner mailbox permission audit

$mb= Get-Mailbox -resultsize unlimited | Where {($_.RecipientTypeDetails -ne "RoomMailbox")}

$mb | ForEach-Object {

    $mailbox = $_.userprincipalname
    $mailbox



$perm = Get-MailboxPermission -Identity $mailbox | Select Identity, User, AccessRights| Where {($_.user -ne "NT AUTHORITY\SELF")}


$report = [pscustomobject]@{
    MailboxUPN = $mailbox
    Identity = $perm.identity
    Delegate = $perm.User
    AccessRights = $perm.AccessRights
}



$report| Export-Csv -Append -path d:\temp\NonOwner_MailboxPermissions.csv -NoTypeInformation -Force
}

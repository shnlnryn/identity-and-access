## Revoke Azure tokens for a list of users by upn

$csv = Import-Csv -Path D:\Temp\users.csv

ForEach ($u in $csv){


$obj = get-azureaduser -objectid $u.login |select objectid

$obj
$u.login


Revoke-AzureADUserAllRefreshToken -ObjectId $obj.objectid

}

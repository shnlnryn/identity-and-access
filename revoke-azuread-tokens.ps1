$csv = Import-Csv -Path D:\Temp\userlist.csv

ForEach ($u in $csv){


$obj = get-azureaduser -objectid $u.login |select objectid

$obj
$u.login


Revoke-AzureADUserAllRefreshToken -ObjectId $obj.objectid

}

Get-ADGroupmember -identity "myGroup" | % { get-aduser $_.samaccountname | select name,userprincipalname } | export-csv c:\temp\upn.csv -notypeinformation  

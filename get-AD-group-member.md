Get-ADGroupmember -identity "Staff-College-Academic" | % { get-aduser $_.samaccountname | select name,userprincipalname } | export-csv c:\temp\upn.csv -notypeinformation  

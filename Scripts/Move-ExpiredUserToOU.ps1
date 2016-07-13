$users = Search-ADAccount -UsersOnly -AccountExpired -SearchBase "OU=Arden,OU=DK,OU=Users,OU=Qubiqa,DC=domain,DC=local" | 
Where-Object { $_.DistinguishedName -notmatch ",OU=Ophørte," } | 
Move-ADObject -TargetPath "OU=Ophørte,OU=Arden,OU=DK,OU=Users,OU=Qubiqa,DC=domain,DC=local"
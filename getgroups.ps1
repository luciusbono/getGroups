param($Name, $path = [Environment]::GetFolderPath("Desktop")+'\'+$Name+'-groupmemberships'+'.csv')

$modName = 'ActiveDirectory'
If (-not(Get-Module -name $modName)) { 
	If (Get-Module -ListAvailable | Where-Object { $_.name -eq $modName }) { 
		Import-Module -Name $modName 
		Write-Host "Loaded " $modName " module."
		}
	else {
		Write-Host $modName " module not available. Unable to continue." 
		}
	}

function TruncateCN 
{
param([string]$DN=(Throw '$DN is required!'))
    foreach ( $item in ($DN.replace('\,','~').split(",")))
    {
        switch -regex ($item.TrimStart().Substring(0,3))
        {
            "OU=" {$ou += ,$item.replace("OU=","");$ou += '/';continue}
        }
    } 
    for ($i = $ou.count;$i -ge 0;$i -- )
	{
	$truncated += $ou[$i]
	}
    return $truncated.substring(1)
}

(Get-ADUser -Identity $Name –Properties MemberOf | Select MemberOf).MemberOf | Get-ADGroup -Properties ManagedBy | Select Name, ManagedBy, Distinguishedname, GroupCategory | 
	Where-Object {
				$_.Distinguishedname -notlike "*Unity*" -and $_.Distinguishedname -notlike "*DynastyGroups*" -and $_.name -notlike "*Technical Library*"}|
	ForEach-Object {
   If ($_.ManagedBy) {
      $result = New-Object PSObject
      Add-Member -input $result NoteProperty 'Group Name' $_.Name
      Add-Member -input $result NoteProperty 'Managed By' ((Get-ADUser -Identity $_.ManagedBy).givenName + ' ' + ((Get-ADUser -Identity $_.ManagedBy).surName))
      Add-Member -input $result NoteProperty 'Email' (Get-ADUser -Identity $_.ManagedBy -Properties mail).Mail
	  Add-Member -input $result NoteProperty 'OU' (TruncateCN $_.Distinguishedname)
	  Add-Member -input $result NoteProperty 'Group Type' $_.GroupCategory
      Write-Output $result
   }
   else {
      $result = New-Object PSObject
      Add-Member -input $result NoteProperty 'Group Name' $_.Name
      Add-Member -input $result NoteProperty 'Managed By' "Empty"
	  Add-Member -input $result NoteProperty 'OU' (TruncateCN $_.Distinguishedname)
	  Add-Member -input $result NoteProperty 'Group Type' $_.GroupCategory
      Write-Output $result
   }
   
} | select 'Group Name','Managed By',Email, 'OU', 'Group Type' | sort 'Managed By' | Export-Csv -NoTypeInformation $path

If (Test-Path $path) { Write-Host -NoNewline `n"Groups for user" (Get-ADUser -Identity $Name).Name "exported to the following file:" `n `n $path `n `n}



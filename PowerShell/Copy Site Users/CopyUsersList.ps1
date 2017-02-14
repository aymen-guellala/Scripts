## Load the SharePoint Snapin so the script can be executed from PowerShell editor 
Add-PSSnapin Microsoft.SharePoint.PowerShell -erroraction SilentlyContinue

## Parameters
Write-Host 'Powershell Script will initialize parameters'
$CurrentDir=$args[0]
$WebUrl = $args[1]
$ListName = $args[2]
$logfile=$CurrentDir + '\CopyUsersList.log'


Start-Transcript $logfile
#$errorActionPreference = 'Inquire'
Clear

## get the default web app 
$web = Get-SPWeb $WebUrl
## get the user info list 
$source = $web.Lists | where { $_.Title -eq 'User Information List'}

## Create list
Write-Host '1- Creating List "'$ListName'" if doesn''t exist'
$dest = $web.Lists | where { $_.Title -eq $ListName }
if ($dest -eq $null) {
	$guid = $web.Lists.Add($ListName , "", 100)
	$dest = $web.Lists[$guid]
	$spFieldType = [Microsoft.SharePoint.SPFieldType]::Text
	$dest.Fields.Add('Account' ,$spFieldType,$false) | Out-Null
	$dest.Fields.Add('Email', $spFieldType,$false)	| Out-Null
	Write-Host '	List "'$ListName'" created'
}
else{
	Write-Host '	List already exists'
}

## Clearing list dest
Write-Host '2- Clearing list "'$ListName'"'
$count = $dest.Items.Count
for($intIndex = $count - 1; $intIndex -gt -1; $intIndex--) 
{ 
        $dest.Items.Delete($intIndex); 
}
Write-Host '	'$count ' Item(s) deleted'

## Coping users
Write-Host '3- Coping users to list "'$ListName'"'
foreach($item in $source.Items)
{
	#Create a new item
	$newItem = $dest.Items.Add()
	 
	#Add properties to this list item
	$newItem['Title'] = $item.Title
	$newItem['Account'] = $item['Account']
	$newItem['Email'] = $item['E-mail']
	 
	#Update the object so it gets saved to the list
	$newItem.Update()

}
Write-Host '	'$source.Items.Count ' Item(s) copied'

Stop-Transcript
Remove-PsSnapin Microsoft.SharePoint.PowerShell


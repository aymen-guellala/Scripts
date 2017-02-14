Add-PsSnapin Microsoft.SharePoint.PowerShell

Write-Host 'Powershell Script will initialize parameters'
$CurrentDir=$args[0]
$WebAppUrl = $args[1]
$RootSiteUrl=$args[2]

$solutionName="HSC.Intranet.wsp"

$InstallSite_RootSite = $true
$InstallSite_ApplicationInformatique = $true
$InstallSite_Bottin = $true
$InstallSite_Communication = $true
$InstallSite_DocumentsAdministratifs = $true
$InstallSite_Organisation = $true
$InstallSite_ReferencesClinique = $true
$InstallSite_VieAuTravail = $true

$SiteUrl_ApplicationInformatique = $RootSiteUrl + "/ApplicationsInformatiques"
$SiteUrl_Bottin = $RootSiteUrl + "/Bottin"
$SiteUrl_Communication = $RootSiteUrl + "/Communications"
$SiteUrl_DocumentsAdministratifs = $RootSiteUrl + "/DocumentsAdministratifs"
$SiteUrl_Organisation = $RootSiteUrl + "/Organisation"
$SiteUrl_ReferencesClinique = $RootSiteUrl + "/ReferencesCliniques"
$SiteUrl_VieAuTravail = $RootSiteUrl + "/VieTravail"

$f_M_Archetypes = "e5a2a076-f419-4a0c-a5c8-f7741092f889"
$f_M_ListDefinition = "f4ff7da1-8a16-4edf-9f41-82975cd049a6"
$f_M_MaterPages = "bad64d70-921d-4f3d-bc68-c050f7323174"
$f_M_StyleLibrary = "ca785e8e-284a-4883-8544-5aa92210f4bd"
$f_M_CreateSites = "8dd430af-bf81-4ec9-9122-b805a63a2d33"

$f_S_RootSite = "649be339-b0e0-4cc8-8869-5ddf86f602bf"
$f_S_ApplicationInformatique = "0c4b3829-5b85-4d92-b4ba-4851fbffb83d"
$f_S_Bottin = "7bfc060e-5114-4a0b-bccb-74af1ec54e41"
$f_S_Communication = "6dabbb49-4a05-4abf-a422-33b5d7df1e2d"
$f_S_DocumentsAdministratifs = "86d28bde-4518-4d9a-80a7-68178ec9ddd2"
$f_S_Organisation = "fb2bbac0-737f-4406-a9bc-2fc4e89b95c1"
$f_S_ReferencesClinique = "b26238c8-29e5-4016-b10f-be0d6aa173d1"
$f_S_VieAuTravail = "48365a9d-8fc9-47b3-ae0e-7ea156c3476b"

Start-Transcript $logfile

$errorActionPreference = 'Inquire'

cls

Write-Host '- Activating features' -foregroundcolor Yellow 

	Write-Host 'Powershell Script will now enable feature: Archetypes' -foregroundcolor Cyan 
	Enable-SPFeature -Identity $f_M_Archetypes -Url $RootSiteUrl -Force -Confirm:$false

	Write-Host 'Powershell Script will now enable feature: Lists definitions' -foregroundcolor Cyan 
	Enable-SPFeature -Identity $f_M_ListDefinition -Url $RootSiteUrl -Force -Confirm:$false

	Write-Host 'Powershell Script will now enable feature: Style library' -foregroundcolor Cyan 
	Enable-SPFeature -Identity $f_M_StyleLibrary -Url $RootSiteUrl -Force -Confirm:$false

	Write-Host 'Powershell Script will now enable feature: Master pages' -foregroundcolor Cyan 
	Enable-SPFeature -Identity $f_M_MaterPages -Url $RootSiteUrl -Force -Confirm:$false

	Write-Host 'Powershell Script will now enable feature: Create sites' -foregroundcolor Cyan 
	Enable-SPFeature -Identity $f_M_CreateSites -Url $RootSiteUrl -Force -Confirm:$false

		if($InstallSite_RootSite -eq $True)
		{
		Write-Host 'Powershell Script will now enable feature: Site - Root Site' -foregroundcolor Cyan 
		Enable-SPFeature -Identity $f_S_RootSite -Url $RootSiteUrl -Force -Confirm:$false
		}
		if($InstallSite_ApplicationInformatique -eq $True)
		{
		Write-Host 'Powershell Script will now enable feature: Site - Applications informatiques' -foregroundcolor Cyan 
		Enable-SPFeature -Identity $f_S_ApplicationInformatique -Url $SiteUrl_ApplicationInformatique -Force -Confirm:$false
		}
		if($InstallSite_Bottin -eq $True)
		{
		Write-Host 'Powershell Script will now enable feature: Site - Bottin' -foregroundcolor Cyan 
		Enable-SPFeature -Identity $f_S_Bottin -Url $SiteUrl_Bottin -Force -Confirm:$false
		}
		if($InstallSite_Communication -eq $True)
		{
		Write-Host 'Powershell Script will now enable feature: Site - Communication' -foregroundcolor Cyan 
		Enable-SPFeature -Identity $f_S_Communication -Url $SiteUrl_Communication -Force -Confirm:$false
		}
		if($InstallSite_DocumentsAdministratifs -eq $True)
		{
		Write-Host 'Powershell Script will now enable feature: Site - Documents Administratifs' -foregroundcolor Cyan 
		Enable-SPFeature -Identity $f_S_DocumentsAdministratifs -Url $SiteUrl_DocumentsAdministratifs -Force -Confirm:$false
		}
		if($InstallSite_Organisation -eq $True)
		{
		Write-Host 'Powershell Script will now enable feature: Site - Organisation' -foregroundcolor Cyan 
		Enable-SPFeature -Identity $f_S_Organisation -Url $SiteUrl_Organisation -Force -Confirm:$false
		}
		if($InstallSite_ReferencesClinique -eq $True)
		{
		Write-Host 'Powershell Script will now enable feature: Site - References cliniques' -foregroundcolor Cyan 
		Enable-SPFeature -Identity $f_S_ReferencesClinique -Url $SiteUrl_ReferencesClinique -Force -Confirm:$false
		}
		if($InstallSite_VieAuTravail -eq $True)
		{
		Write-Host 'Powershell Script will now enable feature: Site - Vie au travail' -foregroundcolor Cyan 
		Enable-SPFeature -Identity $f_S_VieAuTravail -Url $SiteUrl_VieAuTravail -Force -Confirm:$false
		}


Stop-Transcript

Remove-PsSnapin Microsoft.SharePoint.PowerShell
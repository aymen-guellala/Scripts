<#
.DESCRIPTION 
    Created an Active Directory Domain
.NOTES
    Requirements : 	You must be logged as Administrator
	Version : 		1.0
	Author :		Sébastien Levert
	Date :			2016/02/10
.PARAMETER NetBiosName
	The NetBiosName (without extension) of the new Domain
.EXAMPLE
	.\Create-Domain.ps1 -NetBiosName "DOMAINNAME"
#>

#region Parameters
Param(
	[Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()]
    [String]$NetBiosName
)
#endregion

#region Private Functions

function Install-PreRequisites
{
    Add-WindowsFeature -Name "AD-Domain-Services" -IncludeAllSubFeature -IncludeManagementTools 
    Add-WindowsFeature -Name "DNS" -IncludeAllSubFeature -IncludeManagementTools 
    Add-WindowsFeature -Name "GPMC" -IncludeAllSubFeature -IncludeManagementTools
}

function Promote-Domain
{
    Param(
		[Parameter(Mandatory = $true)] 
		[String]$DomainName,

		[Parameter(Mandatory = $true)] 
		[String]$NetBiosName,

		[Parameter(Mandatory = $true)] 
		[Security.SecureString]$DSRMPassword
	)

    Import-Module ADDSDeployment
    Install-ADDSForest -CreateDnsDelegation:$false -DatabasePath "C:\Windows\NTDS" -DomainMode "Win2012" -DomainName $DomainName -DomainNetbiosName $NetBiosName -ForestMode "Win2012" -InstallDns:$true -LogPath "C:\Windows\NTDS" -NoRebootOnCompletion:$true -SysvolPath "C:\Windows\SYSVOL" -SafeModeAdministratorPassword $DSRMPassword -Force:$true
}

function Set-DNS
{
    Param(
		[Parameter(Mandatory = $true)] 
		[String]$Address1,

		[Parameter(Mandatory = $true)] 
		[String]$Address2
	)

    Set-DNSClientServerAddress -InterfaceIndex 12 –ServerAddresses ($Address1, $Address2)
}

#endregion

#region Constants
$scriptPathName = $MyInvocation.MyCommand.Definition
$scriptName = $MyInvocation.InvocationName
$scriptPath = "C:\_"
$localAdmin = "Administrator"
$localAdminPassword = "pass@word1"
$domainName = $NetBiosName.ToLower() + ".local" 
$FQDN = "DC=" + $NetBiosName + ",DC=local"
$domainAdmin = "$NetBiosName\$localAdmin"
$domainAdminPassword = "pass@word1"
$dsrmPasswordTxt = "pass@word1"
#endregion

#region Execution
Install-PreRequisites
Promote-Domain -DomainName $domainName -NetBiosName $NetBiosName -DSRMPassword (ConvertTo-SecureString -AsPlainText -Force -String $dsrmPasswordTxt)
Set-Dns -Address1 "10.1.5.10" -Address2 "8.8.8.8"
#endregion
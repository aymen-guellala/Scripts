<#
.DESCRIPTION 
    Joins this computer to the specified Domain
.NOTES
    Requirements : 	You must be logged as Administrator
	Version : 		1.0
	Author :		Sébastien Levert
	Date :			2016/02/10
.PARAMETER NetBiosName
	The NetBiosName (without extension) of the new Domain
.EXAMPLE
	.\Join-Domain.ps1 -NetBiosName "DOMAINNAME"
#>

#region Parameters
Param(
	[Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()]
    [String]$NetBiosName
)
#endregion

#region Constants
$administratorUsername = "Administrator"
$administratorPassword = "pass@word1" | ConvertTo-SecureString -asPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential($administratorUsername, $administratorPassword)
#endregion

#region Execution
Add-Computer -DomainName $NetBiosName -Credential $credential
#endregion
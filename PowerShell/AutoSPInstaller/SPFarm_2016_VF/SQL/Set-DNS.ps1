<#
.DESCRIPTION 
    Assignes the DNS for this computer
.NOTES
    Requirements : 	You must be logged as Administrator
	Version : 		1.0
	Author :		Sébastien Levert
	Date :			2016/02/10
.PARAMETER DomainDNSAddress
	The DomainDNSAddress to assign
.EXAMPLE
	.\Set-DNS.ps1 -DomainDNSAddress "1.1.1.1"
#>

#region Parameters
Param(
	[Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()]
    [String]$DomainDNSAddress
)
#endregion

#region Constants
$backupDNSAddress = "10.1.5.10"
#endregion

#region Execution
Set-DNSClientServerAddress -InterfaceIndex 12 –ServerAddresses ($DomainDNSAddress, $backupDNSAddress)
#endregion
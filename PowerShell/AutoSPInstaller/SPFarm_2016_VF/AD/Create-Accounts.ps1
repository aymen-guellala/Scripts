<#
.DESCRIPTION 
    Adds the specified users to the Active Directory
.NOTES
    Requirements : 	You must be logged as Domain Administrator
	Version : 		1.0
	Author :		Sébastien Levert
	Date :			2014/10/01
.PARAMETER AccountsFilePath
	Path to the Accounts File folder (In the format C:\Path\To\Accounts\File\Folder)
.PARAMETER OrganizationalUnitName
	The name of the OU in which the accounts are created
.EXAMPLE
	.\Create-Accounts.ps1 -AccountsFilePath "C:\Path\To\Accounts\File\Folder" -OrganizationalUnitName "Organizational Unit Name"
#>

#region Parameters
Param (
    [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()]
    [String]$AccountsFilePath,
	
    [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()]
    [String]$OrganizationalUnitName
)
#endregion

#region Private Methods
function Create-OrganizationalUnit()
{
	Param(
		[Parameter(Mandatory = $true)] 
		[String]$DistinguishedName,
		
		[Parameter(Mandatory = $true)] 
		[String]$OrganizationalUnitName
	)
	
	Process {
		$domain = [ADSI]"LDAP://$DistinguishedName"

		if(($domain.PSBase.Children | Where-Object { $_.Name -eq $OrganizationalUnitName }) -eq $null)
		{
			$newOrganizationalUnit = $domain.Create("OrganizationalUnit", "ou=$OrganizationalUnitName")
			$newOrganizationalUnit.SetInfo()
		}

        return $domain.PSBase.Children | Where-Object { $_.Name -eq $OrganizationalUnitName } 
	}
}
 
function Create-User()
{
	Param(		
		[Parameter(Mandatory = $true)] 
		$OrganizationalUnitDistinguishedName,
		
		[Parameter(Mandatory = $true)] 
		[String]$DomainName,
		
		[Parameter(Mandatory = $true)] 
		[String]$FirstName,
		
		[Parameter(Mandatory = $true)] 
		[String]$LastName,
		
		[Parameter(Mandatory = $true)] 
		[String]$UserName,
		
		[Parameter(Mandatory = $true)] 
		[String]$Description,
		
		[Parameter(Mandatory = $true)] 
		[String]$Password
	)
	
	Process {  
		$OrganizationalUnit = [ADSI]"LDAP://$OrganizationalUnitDistinguishedName"  
 
		if(($OrganizationalUnit.PSBase.Children | Where-Object { $_.Name -eq $UserName }) -eq $null)
		{
			$user = $OrganizationalUnit.Create("user", "cn=$UserName")
			$user.Put("sAMAccountName", "$UserName")
			$user.Put("userprincipalname", "$UserName@$DomainName")
			$user.Put("description", $Description)
			$user.put("pwdLastset", -1) 
			$user.SetInfo()
			$user.SetPassword("$Password")
			$user.SetInfo()
			$user.psbase.InvokeSet('FirstName', $FirstName)
			$user.SetInfo()
			$user.psbase.InvokeSet("LastName", $LastName)
			$user.SetInfo()
			$user.psbase.invokeset("AccountDisabled", "False")
			$user.SetInfo()
			
			$currentUAC = [int]($user.userAccountCOntrol.ToString())
			$newUAC =  $currentUAC -bor 65536
			$user.Put("userAccountControl", $newUAC)
			$user.SetInfo()
			
			Write-Host "$UserName has been created"
		}
		else
		{
			Write-Warning "$UserName already exists"
		}
	}
}
#endregion

#region Execution
# Builds the domain
$domainName = $env:userdnsdomain
$domain = [ADSI]"LDAP://$domainName" 
$domainDistinguishedName = $domain.DistinguishedName

# Creating the OrganizationalUnit
$organizationalUnit = Create-OrganizationalUnit -DistinguishedName $domainDistinguishedName -OrganizationalUnitName $OrganizationalUnitName
[xml]$accounts = Get-Content $AccountsFilePath

# Creating each user in the OrganizationalUnit
$accounts.ServiceAccounts.User | ForEach-Object {
	Create-User -DomainName $domainName -OrganizationalUnitDistinguishedName $organizationalUnit.DistinguishedName -FirstName $_.FirstName -LastName $_.LastName -UserName $_.UserName -Description $_.Description -Password $_.Password
}
#endregion
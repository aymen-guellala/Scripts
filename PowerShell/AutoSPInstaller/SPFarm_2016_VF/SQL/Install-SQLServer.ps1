
<#
.DESCRIPTION 
    Install SQL Server as the default instance
.NOTES
    Requirements : 	You must be logged as Administrator
	Version : 		1.0
	Author :		Sébastien Levert
	Date :			2014/09/17
.PARAMETER SourcePath
	The path to the Source of SQL (In the format C:\Path\To\SQL\Install\Folder)
.EXAMPLE
	.\Install-SQLServer.ps1 -SourcePath "C:\Path\To\SQL\Install\Folder" -ConfigFilePath "C:\Path\To\Config\Folder"
#>

#region Parameters
Param (
    [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()]
    [String]$SourcePath,
	
    [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()]
    [String]$ConfigFilePath
)
#endregion

#region Execution 
$arguments = " /QS /ConfigurationFile=$ConfigFilePath /IAcceptSQLServerLicenseTerms"

if((Start-Process $SourcePath\setup.exe -ArgumentList $arguments -Wait -PassThru).ExitCode -eq 0) 
{
	Write-Host -ForegroundColor Green "SQL Server was install with success"
}
#endregion
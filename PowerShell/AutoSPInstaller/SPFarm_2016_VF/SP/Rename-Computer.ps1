<#
.DESCRIPTION 
    Renames this computer to the specified ComputerName
.NOTES
    Requirements : 	You must be logged as Administrator
	Version : 		1.0
	Author :		Sébastien Levert
	Date :			2016/02/10
.PARAMETER ComputerName
	The ComputerName to assign
.EXAMPLE
	.\Rename-Computer.ps1 -ComputerName "ComputerName"
#>

#region Parameters
Param(
	[Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()]
    [String]$ComputerName
)
#endregion

#region Execution
Rename-Computer $ComputerName
#endregion
<#
.DESCRIPTION 
    Change the ExecutionPolicy for all future PS Scripts
.NOTES
    Requirements : 	You must be logged as Administrator
	Version : 		1.0
	Author :		Sébastien Levert
	Date :			2014/10/01
.PARAMETER Policy
	The policy to apply on the execution context
.EXAMPLE
	.\Change-ExecutionPolicy.ps1 -PolicyType "Policy Type"
#>

#region Parameters
Param(
	[Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()]
    [String]$PolicyType
)
#endregion

#region Execution
Set-ExecutionPolicy -ExecutionPolicy $PolicyType -Force
#endregion
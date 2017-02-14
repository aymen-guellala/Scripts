<#
.DESCRIPTION 
    Deactivate LUA UAC to permit the creation of new file everywhere (NTFS Right)
.NOTES
    Requirements : 	You must be logged as Administrator
	Version : 		1.0
	Author :		Sébastien Levert
	Date :			2014/10/01
.EXAMPLE
	.\Disable-LUA.ps1
#>

#region Execution
$lua = Get-ItemProperty -Path HKLM:Software\Microsoft\Windows\CurrentVersion\Policies\System -Name "EnableLUA"

if($val.EnableLUA -ne 0)
{
    Set-ItemProperty -Path HKLM:Software\Microsoft\Windows\CurrentVersion\Policies\System -Name "EnableLUA" -Value 0
}
#endregion
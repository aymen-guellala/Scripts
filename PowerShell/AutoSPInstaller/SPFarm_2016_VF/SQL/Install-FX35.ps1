<#
.DESCRIPTION 
    Install DotNet FrameWork 3.5
.NOTES
    Requirements : 	You must be logged as Administrator
	Version : 		1.0
	Author :		Sébastien Levert
	Date :			2014/09/17
.PARAMETER SourcePath
	The path to the sxs Source of Windows 2012 (In the format C:\Path\To\sxs\Folder)
.EXAMPLE
	.\Install-FX35.ps1 -SourcePath "C:\Path\To\sxs\Folder"
#>

#region Parameters
Param (
    [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()]
    [String]$SourcePath
)
#endregion

#region Execution 
$arguments = "/Online /Enable-Feature /FeatureName:NetFx3 /All /LimitAccess /Source:$SourcePath"
$succeeded = (Start-Process "DISM.exe" -ArgumentList $arguments -Wait -NoNewWindow -PassThru).ExitCode -eq 0
#endregion
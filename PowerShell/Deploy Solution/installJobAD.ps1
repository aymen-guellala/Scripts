Add-PsSnapin Microsoft.SharePoint.PowerShell

Write-Host 'Powershell Script will initialize parameters'
$CurrentDir=$args[0]
$WebAppUrl=$args[1]
$SiteUrl=$args[2]
$WebUrl=$args[3]

$solutionName="ADUsersManagement.wsp"

$featureName="b9c1c80d-fb1d-449c-898c-ec8934ee1f09"


$SolutionPath=$CurrentDir + "\"+$solutionName
$logfile=$CurrentDir + "\logInstallJobAD.log"

Start-Transcript $logfile

$errorActionPreference = 'Inquire'

Write-Host 'Powershell Script will now disable feature:' $featureName
Disable-SPFeature -Identity $featureName -Url $SiteUrl -Force -Confirm:$false

Write-Host 'Powershell Script will now retract solution:' $solutionName
Uninstall-SPSolution -Identity $solutionName -WebApplication $WebAppUrl  -Confirm:$false 
Start-Sleep -s 15
Start-SPAdminJob


write-Host 'Please wail'
$s = get-spsolution -identity $solutionName
while ($s.JobExists -eq $True) { [System.String]::Format("JobStatus = '{0}' - Status = '{1}' - Deployed = '{2}'", $s.JobStatus, $s.Status, $s.Deployed); sleep 2}
$s.LastOperationDetails

Write-Host 'Powershell Script will now remove solution:' $solutionName
Remove-SPSolution -Identity $solutionName -Force -Confirm:$false


Write-Host 'Powershell Script will now add solution:' $solutionName
write $SolutionPath
Add-SPSolution $SolutionPath

Write-Host 'Powershell Script will now deploy solution:' $solutionName
Install-SPSolution -Identity $solutionName -WebApplication $WebAppUrl   -GACDeployment  -Force
Start-Sleep -s 15

Start-SPAdminJob

write-Host 'Please wail'
$s = get-spsolution -identity $solutionName
while ($s.JobExists -eq $True) { [System.String]::Format("JobStatus = '{0}' - Status = '{1}' - Deployed = '{2}'", $s.JobStatus, $s.Status, $s.Deployed); sleep 2}
$s.LastOperationDetails


Write-Host 'Powershell Script will now enable feature:' $featureName
Enable-SPFeature -Identity $featureName -Url $SiteUrl -Force -Confirm:$false


Stop-Transcript

Remove-PsSnapin Microsoft.SharePoint.PowerShell
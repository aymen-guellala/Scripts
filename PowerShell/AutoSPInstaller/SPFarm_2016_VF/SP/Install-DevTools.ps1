<#
.DESCRIPTION 
    Installs all the DevTools on the machine
.NOTES
    Requirements : 	You must be logged as Administrator
	Version : 		1.0
	Author :		S�bastien Levert
	Date :			2016/02/16
.EXAMPLE
	.\Install-DevTools.ps1
#>

#region Execution
iex ((New-Object Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
Start-Process powershell.exe -ArgumentList "choco install git -y" -Wait -PassThru
Start-Process powershell.exe -ArgumentList "choco install nodejs.install -y" -Wait -PassThru
Start-Process powershell.exe -ArgumentList "choco install webpi -y" -Wait -PassThru
Start-Process powershell.exe -ArgumentList "choco install compass -y" -Wait -PassThru
Start-Process powershell.exe -ArgumentList "npm install -g yo" -Wait -PassThru
Start-Process powershell.exe -ArgumentList "choco install 7zip.install -y" -Wait -PassThru
Start-Process powershell.exe -ArgumentList "choco install sharepointmanager2013 -y" -Wait -PassThru
Start-Process powershell.exe -ArgumentList "choco install ulsviewer -y" -Wait -PassThru
Start-Process powershell.exe -ArgumentList "choco install notepadplusplus.install -y" -Wait -PassThru
Start-Process powershell.exe -ArgumentList "choco install visualstudio2015enterprise -y" -Wait -PassThru
Start-Process powershell.exe -ArgumentList "choco install visualstudiocode -y" -PassThru
#endregion
<#
.DESCRIPTION 
    Enables Remote Desktop and Firewall settings to connect to the machine
.NOTES
    Requirements : 	You must be logged as Administrator
	Version : 		1.0
	Author :		Sébastien Levert
	Date :			2016/02/16
.EXAMPLE
	.\Enable-RDP.ps1
#>

#region Execution
netsh advfirewall set allprofiles state off
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server' -Name fDenyTSConnections -Value 0
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -Name UserAuthentication -Value 1
Set-NetFirewallRule -DisplayGroup 'Remote Desktop' -Enabled True
#endregion
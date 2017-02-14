cd /d %~dp0
powershell -noexit -file ".\CopyUsersList.ps1" "%CD%" "http://splab.vicdev.ca/" "SiteUsers"



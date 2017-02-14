@set PATH=C:\Program Files (x86)\Microsoft SDKs\Windows\v7.0A\Bin\NETFX 4.0 Tools\x64;%PATH%

gacutil.exe -i "C:\Users\Aymen-GUELLALA\Documents\TFS\Decade\SharePoint\ADUsersManagement\ADUsersManagement\bin\debug\ADUsersManagement.dll"

iisreset

net stop SPTimerV4
net start SPTimerV4

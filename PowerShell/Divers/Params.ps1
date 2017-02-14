  param(
        [Parameter(Position=0,Mandatory=$true,HelpMessage="How many cups would you like to purchase?")]
        [ValidateSet('word','excel','powerpoint')]
        [System.String]$Application,

        [Parameter(Position=1)]
        [ValidateSet('v2007','v2010')]
        [System.String]$Version="5",

        [Parameter(Position=3,Mandatory=$true)]
        [System.String]$Update
    )

Write-Host "Application : $Application"
Write-Host "Version : $Version"
    


Write-Host "End process, press any key to exit ..." -ForegroundColor White -BackgroundColor Red
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')

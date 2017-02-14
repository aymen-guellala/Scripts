param (
    [Parameter(
         Mandatory=$true,
         Position=1,
         HelpMessage="Please type the web url."
      )]
      [string]$WebUrl,
    
      [Parameter(
         Mandatory=$true,
         Position=2,
         HelpMessage="Please type the document library's name."
      )]
      [string]$DocumentLibrary,

      [Parameter(
         Mandatory=$true,
         Position=3,
         HelpMessage="Please type the number of versions to keep."
      )]
      [int]$NumberOfVersions,
    
     [Parameter(
         Mandatory=$true,
         Position=4,
         HelpMessage="Please type the column name."
      )]
      [string]$ColumnName
)

 if ( (Get-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null ) 
 {
     Add-PSSnapin Microsoft.SharePoint.Powershell
 }

Set-Location -Path (split-path -parent $MyInvocation.MyCommand.Definition)

$logfile=".\CleanVersions-"+ [System.DateTime]::Now.ToString("yyMMddHHmmss")  +".log"
Start-Transcript $logfile

cls

Write-Host "`r`n---------------------------------------------------------------------`r`n"
Write-Host "`r`nWeb Url            : $WebUrl"
Write-Host "`r`nLibrary Name       : $DocumentLibrary"
Write-Host "`r`nNumber of Versions : $NumberOfVersions"
Write-Host "`r`nColumn             : $ColumnName"
Write-Host "`r`n---------------------------------------------------------------------`r`n"

$Web = Get-SPWeb  $WebUrl
$List = $Web.Lists[$DocumentLibrary]
$TimetoDelete = (Get-Date).Adddays(-180)

if  ($List.EnableMinorVersions -eq $true) {
	Write-Host "`r`nNothing was done because minor versions are enabled" -foreground Red
}
elseif ($List.EnableVersioning -eq $true) {	 
    $Items = 	$List.Items | Where-Object {(($_.File.TimeLastModified -lt $TimetoDelete) -and (($_.File.Versions.count -gt $NumberOfVersions) -and ($_[$ColumnName] -eq "Completed")))}
	
    Write-Host  "`r`n $($Items.count) Item(s) to clean in the library '" $List.Title "' `r`n"   -ForegroundColor Green
	foreach ($item in $Items) 
        { 
            $nbVersion = $item.File.Versions.count
	               
            Write-Host "`r`n *******************************************************************"
            Write-Host "`r`n Working on Item ID = $($item.ID) | Url = $($item.URL) "
            Write-Host "`r`n *******************************************************************"      
                                 
            Write-Host "`r`n [#] All versions :" -BackgroundColor White -ForegroundColor Black

            foreach($v in $item.File.Versions)
                {
                        Write-Host "`r`n`tVersion label : $($v.VersionLabel) - Created : $($v.Created) "  -ForegroundColor Green
                }

            Write-Host "`r`n [#] Versions to delete :" -BackgroundColor White -ForegroundColor Black
                  
            for($i=$nbVersion -$NumberOfVersions-1; $i -ge 0; $i--) 
                {
			        #$item.File.Versions[$i].delete()
	                Write-Host "`r`n`tVersion label : $($item.File.Versions[$i].VersionLabel) - Created : $($item.File.Versions[$i].Created) - [$i]"   -ForegroundColor Red
			    } 

			Write-Host "`r`n [#] $($nbVersion - $NumberOfVersions) version(s) deleted of $nbVersion versions" -foreground Black	 -BackgroundColor White		        	
		} 
}
else {
	Write-Host "`r`nNothing was done, versionning is not enabled" -foreground Blue
}

$Web.Dispose();

Write-Host "`r`n Completed ... `r`n"

Stop-Transcript
Remove-PsSnapin Microsoft.SharePoint.PowerShell


Write-Host "End process, press any key to exit ..." -ForegroundColor White -BackgroundColor Red
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')

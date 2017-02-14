$LogTime = Get-Date -Format yyyy-MM-dd_hh-mm
$LogFile = ".\PublishCTHub-$LogTime.rtf"
    
 cls
    
 ##================================================================================================
 ## Description    : This script is used to Publish the Content types and run the subscriber timer jobs.
 ## Author        : Sathish Nadarajan
 ## Date            : 10-Dec-2014
 ##================================================================================================
  
   
 $Host.UI.RawUI.WindowTitle = "-- Publish Content types --"
  
 $StartDate = Get-Date
 Write-Host -ForegroundColor White "------------------------------------"
 Write-Host -ForegroundColor White "| Publish Content Types |"
 Write-Host -ForegroundColor White "| Started on: $StartDate |"
 Write-Host -ForegroundColor White "------------------------------------"
    
  
 #start-transcript $logfile
  
 $ErrorActionPreference = "Stop"
 ######################### Add SharePoint PowerShell Snapin ###############################################
  
 if ( (Get-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null ) 
 {
     Add-PSSnapin Microsoft.SharePoint.Powershell
 }
  
 ########################### End of Add SharePoint PowerShell Snapin ##################################
  
 ######################## Set Execution Path ################################################
  
 $scriptBase = split-path $SCRIPT:MyInvocation.MyCommand.Path -parent
 Set-Location $scriptBase
  
  
 function Publish-ContentTypeHub 
 {
      param
      (
          [parameter(mandatory=$true)][string]$CTHUrl,
          [parameter(mandatory=$true)][string]$Group 
      )
        $site = Get-SPSite $CTHUrl
        if(!($site -eq $null))
      {   #write-host "Republishing Content type" $Group " to make the changes effective" -foregroundcolor Magenta
          $contentTypePublisher = New-Object Microsoft.SharePoint.Taxonomy.ContentTypeSync.ContentTypePublisher($site)
          $site.RootWeb.ContentTypes | ? {$_.Group -match $Group} | % {
          $contentTypePublisher.Publish($_)
          #write-host "Content type" $Group "has been republished successfully ....... Done !" -foregroundcolor Green
         }
      }
 }
  
  
 function StartContentTypeHubTimerJob
 {     
     $job = Get-SPTimerJob | ?{$_.Name -match "MetadataHubTimerJob"}
     if($job -ne $null  )
     {
         $startet = $job.LastRunTime
         Write-Host -ForegroundColor Yellow -NoNewLine "Running"$job.DisplayName"Timer Job."
         Start-SPTimerJob $job
         while (($startet) -eq $job.LastRunTime)
         {
             Write-Host -NoNewLine -ForegroundColor Yellow "."
             Start-Sleep -Seconds 2
         }
         $lastrun = $job.historyentries | select-object -first 1
  
         if($lastrun.status -eq "Succeeded")
         {
             Write-Host -ForegroundColor Green $job.DisplayName"Timer Job has completed.";
         }
  
         else
         {
             Write-Host -ForegroundColor red $job.DisplayName"Timer Job has Failed. Please take necessary actions and rerun the timer jobs";
             exit
         }
  
     }
 }
  
  
 function StartTimerJob([string]$WebAppUrl) 
 {
     $wa = Get-SPWebApplication $WebAppUrl
     write-host "Starting content type subscriber timer job for the web application " $wa.name -fore yellow
     $Job = Get-SPTimerJob -WebApplication $wa | ?{ $_.Name -like "MetadataSubscriberTimerJob"}
     if($job -ne $null  )
     {
         $startet = $job.LastRunTime
         Write-Host -ForegroundColor Yellow -NoNewLine "Running"$job.DisplayName"Timer Job."
         Start-SPTimerJob $job
         while (($startet) -eq $job.LastRunTime)
         {
             Write-Host -NoNewLine -ForegroundColor Yellow "."
             Start-Sleep -Seconds 2
         }
         $lastrun = $job.historyentries | select-object -first 1
  
         if($lastrun.status -eq "Succeeded")
         {
             Write-Host -ForegroundColor Green $job.DisplayName"Timer Job has completed.";
         }
  
         else
         {
             Write-Host -ForegroundColor red $job.DisplayName"Timer Job has Failed.";
         }
  
     }
 }
  
  
  
  
  
 #################Republishing Content type#######################################################
  
 write-host "Republishing associated content types" -fore yellow
  
 $RepublishContentTypeCSV = $scriptBase + "\" + "07.PublishCTHub.RepublishContentType.csv"
  
 import-csv $RepublishContentTypeCSV | where {
     Publish-ContentTypeHub $_.SiteUrl $_.ContentTypeGroupName
 }
  
 write-host "Associated content types republished successfully......... Done !" -fore green
 write-host "loading............." -fore Magenta
 sleep(10)
  
 ############################## Start Content type hub timer job##############
  
 StartContentTypeHubTimerJob
  
 ############################### Start Content Subscription Timer Jobs for Each WEbApplications #####################
  
 $WebApplicationDetailsCSV = $scriptBase + "\" + "07.PublishCTHub.WebApplicationDetails.csv"
  
 import-csv $WebApplicationDetailsCSV | where {
     write-host "loading............." -fore Magenta
     StartTimerJob $_.WebAppUrl
 }
  
 #Stop-Transcript 
  
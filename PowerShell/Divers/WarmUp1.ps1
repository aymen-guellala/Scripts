if ( (Get-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null )
{    Add-PsSnapin Microsoft.SharePoint.PowerShell}
 

function WaitForBrowser{
 param ($theBrowser)
 $maxRetries=20
 $retrySeconds=1
 $retryCounter=0
 while ($theBrowser.Busy -eq $true){  
  Write-Debug "waiting"
  if ($retryCounter -gt $maxRetries){
   return $false
  }
  $retryCounter++ 
  start-sleep $retrySeconds 
 } 
 return $true
}


#$username="CORP\SPD_Eum"
#$password="dsidev*1"

$username="CORP\SPD_Eum"
$password="dsidev*1"  


$ie=New-Object -ComObject "InternetExplorer.Application"
$ie.navigate("http://dev.extranet.admtl.com/_Forms/EZLogin.aspx?ReturnUrl=%2f_layouts%2fAuthenticate.aspx%3floginasanotheruser%3dtrue%26Source%3dhttp%3a%2f%2fdev.extranet.admtl.com%2fPages%2fdefault.aspx&loginasanotheruser=true&Source=http://dev.extranet.admtl.com/Pages/default.aspx")
$ie.visible=$true   #change to $true to watch the fun!
#$retryCounter=3

if ((WaitForBrowser $ie ) -eq $false){
 return #quit LOG SOMETHING!
}else{
 $doc=$ie.Document
}

$txtUsername=$doc.getElementByID("ctl00_ContentPlaceHolder1_signInControl_UserName")
$txtPassword=$doc.getElementByID("ctl00_ContentPlaceHolder1_signInControl_Password")
$btnSubmit=$doc.getElementByID("ctl00_ContentPlaceHolder1_signInControl_LoginButton")
 

$txtUsername.value=$username 
$txtPassword.value=$password 
$btnSubmit.click()

if ((WaitForBrowser $ie ) -eq $false){
 return #quit - we have to get authenticated or else we can't warmup all sites - LOG SOMETHING!
}

$web= Get-SPWeb "http://dev.extranet.admtl.com/"
$webapp=$web.site.WebApplication
$relativeUrls = @("/_layouts/viewlsts.aspx", "/_vti_bin/UserProfileService.asmx", "/_vti_bin/sts/spsecuritytokenservice.svc")

foreach ($site in $webapp.Sites){
    if(($site.Url -notlike "*/Initiatives/*") -and ($site.Url -notlike "*/GroupesDeTravail/*") -and ($site.Url -notlike "*/testinfra/*") -and ($site.Url -notlike "*/sites/*")){
         foreach ($relativeUrl in $relativeUrls){
             $ie.visible=$true
             $ie.Navigate($site.Url+$relativeUrl)
              if ((WaitForBrowser $ie ) -eq $false){
               #LOG SOMETHING! then continue to next site
              }
         }
    }
}
$ie.Quit()
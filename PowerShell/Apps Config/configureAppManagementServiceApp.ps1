
$account = Get-SPManagedAccount "mcatrinescu\sp_farm" 
# Gets the name of the Farm administrators account and sets it to the variable $account for later use.

$appPoolAppSvc = New-SPServiceApplicationPool -Name AppServiceAppPool -Account $account
# Creates an application pool for the Application Management service application. 
# Uses the Farm administrators account as the security account for the application pool.
# Stores the application pool as a variable for later use.

$appAppSvc = New-SPAppManagementServiceApplication -ApplicationPool $appPoolAppSvc -Name AppServiceApp -DatabaseName SP_2013_App_Management_Service_App
# Creates the Application Management service application, using the variable to associate it with the application pool that was created earlier.
# Stores the new service application as a variable for later use.

$proxyAppSvc = New-SPAppManagementServiceApplicationProxy -ServiceApplication $appAppSvc
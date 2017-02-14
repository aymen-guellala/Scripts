 
$account = Get-SPManagedAccount "mcatrinescu\sp_farm" 
# Gets the name of the Farm administrators account and sets it to the variable $account for later use.

$appPoolSubSvc = New-SPServiceApplicationPool -Name SettingsServiceAppPool -Account $account
# Creates an application pool for the Subscription Settings service application. 
# Uses the Farm administrators account as the security account for the application pool.
# Stores the application pool as a variable for later use.

$appSubSvc = New-SPSubscriptionSettingsServiceApplication –ApplicationPool $appPoolSubSvc –Name SettingsServiceApp –DatabaseName SP_2013_Subscriptions_Service_App
# Creates the Subscription Settings service application, using the variable to associate it with the application pool that was created earlier.
# Stores the new service application as a variable for later use.

$proxySubSvc = New-SPSubscriptionSettingsServiceApplicationProxy –ServiceApplication $appSubSvc
# Creates a proxy for the Subscription Settings service application.



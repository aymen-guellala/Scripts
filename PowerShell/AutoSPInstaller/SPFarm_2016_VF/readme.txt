Create Farm
	1- Create machines (AD, SQL,SP)
	2- Set fixed IP (got from network admin) and use the main company DNS
		IP:	 10.1.5.80
		SubnetMask:	255.255.255.0
		Default gateway:	10.1.5.1
		DNS:	10.1.5.10
	3- Enable remote desktop connection  https://www.rootusers.com/how-to-enable-remote-desktop-in-windows-server-2016/
	4- Set-ExecutionPolicy unrestricted
	5- Create Domain
	6- Create domain users (SQL + SP + Dev)
	7- Join Domain (SQL+ SP)
	8- Install SQL
		a. SQl instance
		b. Sql management studio
	9- Install SharePoint 
		a. Sharepoint
		b. Language pack
		c. Sharepoint designer
	10- Install tools
		a. Visual code
		b. Visual studio
		c. NP++
		d. 7zip


Pre-configure for SharePoint
	1- Add account AGFarm\SP_Install to local admin on SharePoint server
	2- Change Max Degree of Parallelism SQL to 1 https://sharepointadam.com/2012/07/20/sql-does-not-have-the-required-maxdegree-of-parallelism-setting-of-1/
	3- Create a login to SP_Install on SQL Server +  Assign the roles : dbcreator, securityadmin
	4- Prepare for user profile synchronization: Gant the "Replicating Directory Changes" permission for the UserProfile (sync) service account https://support.microsoft.com/en-us/kb/303972
	5- Configure DNS: Prepare app domain http://www.widriksson.com/sharepoint-2013-sp1-autospinstaller/
	6- BugFix: Locate the file ‘~16\TEMPLATE\FEATURES\fieldsfieldswss4.xml’ and  delete all occurrence of the attribute “ListInternal”
	
	
	
Configure SharePoint (Standart config)
	1- Config Sharepoint
		a. Autospinstaller
		b. disable internet explorer enhanced security
		c. Enable sign in as another user
		d. Create dev.agfarm.local web app
		e. Set AGFarm\Administrator as farm admin
		f. Check user profile synchro
	2- Install + config tools
		a. Git
		b. Psgit
		c. PS Profile
		d. U2u
		e. Search query
		f. Smtp dev
		g. Fiddler
		h. Postman
		i. Cmdler
		j. Altasian
		k. Pnp
	3- Install
	Microsoft Office Developer Tools Preview 2 for Visual Studio 2015 <https://www.microsoft.com/en-us/download/details.aspx?id=51683> 
	4- Deploy test package (alpha solution)
		a. Webpart
	5- Check admin can access SPFarm via Powershell
		
		
Configure SharePoint (Advanced config)
	1- Config Sharepoint
		a. App catalog https://technet.microsoft.com/en-us/library/fp161236.aspx?f=255&MSPPError=-2147217396
		b. Workflow manager https://cann0nf0dder.wordpress.com/2016/09/08/building-sharepoint-2016-development-environment-part-15-configuring-workflow/
			i. Install-WindowsFeature -Name Web-Mgmt-Service
			ii. Instal wrokflow manager 1.0 CU2 using "Web plateform installer 5.0"
			iii. Install Service bus CU https://www.microsoft.com/en-us/download/details.aspx?id=36794
			iv. Instal wrokflow manager CU 3 using "Web plateform installer 5.0"
			v. Install SP2016 CU October  https://technet.microsoft.com/en-us/library/mt715807(v=office.16).aspx#BKMK_2016
			vi. Register site coll : Register-SPWorkflowService -SPSite "http://dev.agfarm.local/sites/dev" -WorkflowHostUri "http://localhost:12291" -AllowOAuthHttp -Force
		c. DNX + DNVM https://www.microsoft.com/net/core#windows
	2- Deploy test package (alpha solution)
		a. App 
		b. Workflow
		c. DNX




Bug 
	1- Locate the file ‘~16\TEMPLATE\FEATURES\fieldsfieldswss4.xml’ and  delete the attribute values for the four values of “ListInternal” attribute.
À partir de l’adresse <https://whatsthesharepointblog.wordpress.com/2016/10/10/sharepoint-2016-error-listinternal-attribute-not-allowed/> 

References:
	https://support.microsoft.com/en-us/kb/303972
	http://www.widriksson.com/sharepoint-2013-sp1-autospinstaller
	http://blog.fpweb.net/understanding-autospinstaller-what-you-need-to-know/#.WBuvP_nhBhG
	
	https://absolute-sharepoint.com/2013/10/create-a-scripted-sharepoint-2013-development-environment-tutorial-part-1.html
	https://sp2013serviceaccount.codeplex.com/downloads/get/719312
	
	
	

	

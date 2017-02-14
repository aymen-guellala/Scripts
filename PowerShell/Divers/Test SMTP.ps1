$sd = new-object System.collections.specialized.stringdictionary
$sd.add("to","ourrecipient@email.ca")
$sd.add("from","aguellala@victrix.ca")
$sd.add("Subject","The clue is in the name!")
$web = get-spweb "http://splab.vicdev.ca"
$body = "This is our body<br/> We can use <strong>HTML</strong> codes in it."
[Microsoft.SharePoint.Utilities.SPUtility]::SendEmail($web,$sd,$body)
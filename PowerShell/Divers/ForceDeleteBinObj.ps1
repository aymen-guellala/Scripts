Get-ChildItem .\ -include bin,obj -Recurse| Get-ChildItem -include debug,release |foreach ($_) { remove-item $_.fullname -Force -Recurse } 
#Read-Host 'press a key ...' | Out-null

Install-windowsfeature -name AD-Domain-Services -IncludeManagementTools
Add-Type -AssemblyName 'System.Web'
$passwd = [System.Web.Security.Membership]::GeneratePassword(20,4) -replace '[^a-z 0-9]',''
Install-ADDSDomainController -DomainName mydomain.org -SafeModeAdministratorPassword (ConvertTo-SecureString $passwd -AsPlainText -Force)

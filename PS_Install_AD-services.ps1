#Add-Type -AssemblyName 'System.Web'
#$passwd = [System.Web.Security.Membership]::GeneratePassword(20,4) -replace '[^a-z 0-9]',''
$passwd = "P@ssw0rd"

Install-windowsfeature -name AD-Domain-Services -IncludeManagementTools

Install-ADDSForest -DomainName "sfhr.test" -Force -SafeModeAdministratorPassword (ConvertTo-SecureString $passwd -AsPlainText -Force)

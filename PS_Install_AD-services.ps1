Add-Type -AssemblyName 'System.Web'
$passwd = [System.Web.Security.Membership]::GeneratePassword(20,4) -replace '[^a-z 0-9]',''
Install-windowsfeature -name AD-Domain-Services -IncludeManagementTools
Install-ADDSForest -DomainName "sfhr.test" -Force -SafeModeAdministratorPassword (ConvertTo-SecureString $passwd -AsPlainText -Force)
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/raykareer/AzureTestLab/main/setupADusers.ps1"

Restart-Computer

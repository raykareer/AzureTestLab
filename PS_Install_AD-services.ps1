Add-Type -AssemblyName 'System.Web'
$passwd = [System.Web.Security.Membership]::GeneratePassword(20,4) -replace '[^a-z 0-9]',''
Install-windowsfeature -name AD-Domain-Services -IncludeManagementTools
Install-ADDSForest -DomainName "sfhr.test" -Force -SafeModeAdministratorPassword (ConvertTo-SecureString $passwd -AsPlainText -Force)
$startupScript = {$setupADusers = Invoke-WebRequest -Uri "https://raw.githubusercontent.com/raykareer/AzureTestLab/main/setupADusers.ps1"
Invoke-Expression $($setupADusers.content)
Remove-Item C:\Windows\System32\GroupPolicy\Machine\Scripts\Startup\startup.ps1 -Force
}

mkdir C:\Windows\System32\GroupPolicy\Machine\Scripts\Startup
$startupScript | out-file C:\Windows\System32\GroupPolicy\Machine\Scripts\Startup\startup.ps1

Restart-Computer

Add-AzureRmAccount

New-AzureRmResourceGroup -Name gab2016kh -Location "northeurope"

$secpasswd = ConvertTo-SecureString “gab2016.!” -AsPlainText -Force
$creds = New-Object System.Management.Automation.PSCredential (“adminLogin”, $secpasswd)

New-AzureRmSqlServer -ServerName gab2016kh-sql-02 -ResourceGroupName gab2016kh -Location "eastus2" -ServerVersion 12.0 -SqlAdministratorCredentials $creds;


$context = New-AzureStorageContext -StorageAccountKey "Vk0as7x+VodZXeLIxleChtFtoPqJ1RLsxDQn0J9sQw+WeoY7FdBK5MOXFFMQGUtoslYS4pMaEShf9pBWHJFOWw==" -StorageAccountName gab2016khstor01
Set-AzureStorageBlobContent -File .\AW-Sample-1-2016-4-15-21-52.bacpac -Container "backups" -Context $context



https://gab2016khstor01.blob.core.windows.net/backups/AW-Sample-1-2016-4-15-21-52.bacpac
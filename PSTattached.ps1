# List all PST files attached to Outlook 
# using Powershell 
#  
# Idea from vbScript composed by Jonathan Man 

$outlook = New-Object -comObject Outlook.Application
$outlook.Session.Stores | where { ($_.FilePath -like '*.PST') } |  format-list -Property DisplayName, FilePath | Out-File -FilePath C:\Temp\Backuper\PSTattached.txt
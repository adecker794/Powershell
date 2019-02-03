#We make a directory
mkdir c:\temp\monitor
#Set some variables for later use, also get the monitor information
$Monitors = Get-WmiObject WmiMonitorID -Namespace root\wmi
$LogFile = "C:\temp\monitor\$env:computername.csv"
#Add in the computer name and the ID file if that is set, (it usually contains location and user)
$env:computername >> $LogFile
$ID = Get-Content c:\temp\ID.gpo
$ID >> $LogFile
"Manufacturer,Name,Serial" | Out-File $LogFile -append
#Puts the monitor information into a CSV file in a sorted manner
ForEach ($Monitor in $Monitors)
{
    
	$Manufacturer = ($Monitor.ManufacturerName -notmatch 0 | ForEach{[char]$_}) -join ""
	$Name = ($Monitor.UserFriendlyName -notmatch 0 | ForEach{[char]$_}) -join ""
	$Serial = ($Monitor.SerialNumberID -notmatch 0 | ForEach{[char]$_}) -join ""
	
   
	"$Manufacturer,$Name,$Serial" | Out-File $LogFile -append
}
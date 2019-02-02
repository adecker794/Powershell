#Here we are getting the list of computers to use in the script
$computers = Get-Content "C:\Temp\Scripts\timecheck\computers.txt"
#$computers = 'computer'


#The actual code, we foreach computer, test a ping to make sure it is online
foreach($computer in $computers) {
    if (Test-Connection -ComputerName $computer -Count 1 ){
         
        #Here we get the time and timezone from the remote computer and output it to a CSV file
        $timeZone=Get-WmiObject -Class win32_timezone -ComputerName $computer 
        $localTime = Get-WmiObject -Class win32_localtime -ComputerName $computer 
        $output =@{'ComputerName' = $localTime.__SERVER; 
                    'Time Zone' = $timeZone.Caption; 
                    'Current Time' = (Get-Date -Day $localTime.Day -Month $localTime.Month); 
                   } 
        $object = New-Object -TypeName PSObject -Property $output 
        Write-Output $object
        Add-Content C:\Temp\Scripts\timecheck\success.csv "$object"
 
        } 
        #Here we are adding to a CSV file stating the computer was unpingable.
            else{
        
        Add-Content C:\Temp\Scripts\timecheck\failed.csv "$computer, Down"
    }
}


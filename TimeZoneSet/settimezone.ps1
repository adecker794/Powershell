#Here we are getting the list of computers to use in the script
$computers = Get-Content "C:\Temp\Scripts\timecheck\computers2.txt"


#Foreach computer, test connection then set the time zone on the remote machine
foreach ($computer in $computers){
    
    if (Test-Connection -ComputerName $computer -Count 1 ){
        Invoke-Command -ComputerName $computer -ScriptBlock {Set-TimeZone -Name "Central Standard Time" }
        Write-Host "Time zone set on $computer"
    }

}

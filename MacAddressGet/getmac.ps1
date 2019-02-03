#Gets the list of computers
$computers = Get-Content c:\temp\scripts\getmac\computers.txt
#$computers = 'computer'

#Foreach's each computer in the list and then get its mac and adds it to a csv file
foreach($computer in $computers)
{ 
    Write-Host "Starting $computer"
    get-netadapter –CimSession $computer| select SystemName, Name, MacAddress  | Export-CSV -path c:\temp\scripts\getmac\macs.csv -append
    Write-Host "Ending $computer"

} 
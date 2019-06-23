#Determines which computers you want to run script on
$computers = Get-Content C:\Temp\Scripts\setuser\computers.txt

#Define the user
$user = "user"

#Defines the group
$group = "Adminstrators"

#Deletes the old csv files so everytime you run the output to csv is fresh and not overlapping
del C:\temp\Scripts\setuser\success.csv -Recurse
del C:\temp\Scripts\setuser\failed.csv -Recurse

#The script asks the host(you running this) what they want as the password for $user, it also decodes and puts it into a string so the foreach statement can read it properly
$password = Read-Host -prompt "Enter new password for user" -assecurestring
$decodedpassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))

#Foreach statement that loops through each computer in the $computers variable
foreach ($computer in $computers) {
    #Tests the connection
    if (test-Connection -Cn $computer -Count 1 ) {
    #The next few lines are the bread and butter, it queries the computer, adds the $user user if not already in and the sets the paswword
    $computer
    $user = [adsi]"WinNT://$computer/$user"
    $user.SetPassword($decodedpassword)
    $user.UserFlags = 66049
    $user.SetInfo()
    Invoke-Command -ComputerName $computer -ScriptBlock {powershell.exe 
    Add-LocalGroupMember -Group $group -Member "$user" }
    #This writes to the console stating the computer was successful and then adds it to the success csv
    Write-Host -ForegroundColor Green "Setuser successful on $computer"
    Add-Content C:\temp\Scripts\setuser\success.csv  "$computer, Success"
    
    
    } 
    else {
    #This writes to the console stating the computer failed and then adds it to the failed csv
    Write-Host -ForegroundColor Red "$computer is not online, Setuser failed"
    Add-Content C:\temp\Scripts\setuser\failed.csv  "$computer, Down"   
    }


}



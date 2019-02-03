#Here we are getting the list of computers to be used in the script
$computers = Get-Content "C:\temp\scripts\monitor\computers.txt"
#$computers = 'computer'

#Running a foreach and checking if the computers are online
foreach ($computer in $computers){
    if (test-Connection -Cn $computer -Count 1 ) {
        #Setting the execution policy and making a directory on the remote computer
        Invoke-Command -ComputerName $computer -ScriptBlock {powershell.exe Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted  }
        Invoke-Command -ComputerName $computer -ScriptBlock {powershell.exe mkdir c:\temp\monitor }
        #Robocopying the files to the remote computer
        robocopy c:\temp\scripts\monitor\script \\$computer\c$\temp\monitor /S /E /ZB /V /XO /MT:32 /R:2 /W:10
        #Invoking the script on the remote computer
        Invoke-Command -ComputerName $computer -ScriptBlock {powershell.exe "c:\temp\monitor\monitor.ps1" }
        #Robocopying the files from the remote computer back to our workstation for analysis
        robocopy \\$computer\c$\temp\monitor c:\temp\scripts\monitor\finished /S /E /ZB /V /XO /MT:32 /R:2 /W:10
        #Deleting what we put on the remote computer
        Invoke-Command -ComputerName $computer -ScriptBlock {del "c:\temp\monitor" -Recurse }
        #Setting the execution policy back
        Invoke-Command -ComputerName $computer -ScriptBlock {powershell.exe Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Restricted  }
        #These next two lines are only needed if you comment them out in the "monitor.ps1" file
        #$computer >> c:\temp\scripts\monitor\finished\$computer.csv
        #$ID = Get-Content \\$computer\c$\temp\ID.gpo
        #Here we are adding in a space and then adding the pulled file from the remote computer into one comprehensive file.
        "    " >> C:\temp\Scripts\monitor\finished\ALLMONITORS.csv
        $file = Get-Content "c:\temp\scripts\monitor\finished\$computer.csv"
        $file >> C:\temp\Scripts\monitor\finished\ALLMONITORS.csv
        Write-Host -ForegroundColor Green "Monitor check successful on $computer"
        Add-Content C:\temp\scripts\monitor\success.csv  "$computer, Success"
        
        
#These lines write to a file if the computer is not reached by the ping test.
    } 
    else {
        Write-Host -ForegroundColor Red "$computer is not online, monitor check failed"
        Add-Content C:\temp\scripts\monitor\failed.csv  "$computer, Down"   
    }


}
        


           
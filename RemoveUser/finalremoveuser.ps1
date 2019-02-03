#We are getting the computer list used later in the script
$computers = Get-Content 'c:\temp\scripts\removeuser\computers.txt'
        
#The actual code, we foreach computer, test a ping to make sure it is online
foreach($computer in $computers){
    if(test-Connection -Cn $computer -Count 1 ){
        
        #We make a directory on the remote computer to place the files
        Invoke-Command -ComputerName $computer -ScriptBlock {powershell.exe MKDIR c:\temp\profile }
        robocopy C:\temp\scripts\removeuser\removescript \\$computer\c$\temp\profile /S /E  /V /XO /MT:32 /R:2 /W:10
        #Set execution policy and then run the script, then we restrict the execution policy
        Invoke-Command -ComputerName $computer -ScriptBlock {powershell.exe Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted  }
        Invoke-Command -ComputerName $computer -ScriptBlock {powershell.exe 'c:\temp\profile\profiledelete.ps1' }
        Invoke-Command -ComputerName $computer -ScriptBlock {powershell.exe Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Restricted  }

        }
    #If computer is not pingable it will show in the CLI
    else{
    write-output "$computer is not online"
    }

}

#This section is just a deletion of what we sent to the remote computer
$computer = Get-Content 'c:\temp\scripts\removeuser\computers.txt'


foreach($computer in $computers){
    if(test-Connection -Cn $computer -Count 1 ){

        Invoke-Command -ComputerName $computer -ScriptBlock {powershell.exe remove-item "c:\temp\profile" -recurse -force }

        }
    else{
    write-output "$computer is not online"
    }

}

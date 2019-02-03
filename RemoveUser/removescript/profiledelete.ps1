#Set the computer variable
$computers = $env:computername
#Getting the users from the users.txt file
$Users = get-content "C:\temp\profile\users.txt"

#The actual code, 
ForEach($computer in $computers) {
	ForEach($User in $Users){

	#Displays which workstation/server is being checked for each User
	Write-Host -ForegroundColor Yellow “Checking on $Computer for $User profile”        
	Write-Verbose "Working on $Computer"
    
#Queries Win32_UserProfile for all SIDs
If(Test-Connection -ComputerName $Computer -Count 1 -ea 0) {            
	$Profiles = Get-WmiObject -Class Win32_UserProfile -Computer $Computer -ea 0
        
#Translates SIDs into UserName        
foreach ($profile in $Profiles) { 
	$objSID = New-Object System.Security.Principal.SecurityIdentifier($profile.sid)            
	$objuser = $objsid.Translate([System.Security.Principal.NTAccount])            
	$profilename = $objuser.value.split("\")[1] 
    #write-host $profilename

    


if($profilename -eq $User) {            
	$profilefound = $true
                
#Attempts to delete all components of the User Profile, action will fail if user is logged on                
try {            
	$profile.delete()
    Remove-LocalUser $user            
	Write-Host "$User profile deleted successfully on $Computer"            
    }
catch {            
	Write-Host "Failed to delete the profile, $User on $Computer"            
        }            
    } 
    }
    }
    }
    }
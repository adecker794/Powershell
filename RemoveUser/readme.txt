What these set of scripts do:
Profiledelete.ps1 - Takes the users defined in users.txt and removes them from the computer
finalremoveuser.ps1 - Pushes profiledelete.ps1 to remote computers and runs it, and then deletes the script from the remote computer.

Where to place scripts: c:\temp\scripts\removeuser

What to change:
computers.txt - add in your list of computers
users.txt - add in your list of users

Output:
Nothing but what is from the cli.

How to run:
Open in ISE and run(after defining computers.txt and users.txt)
Or just run from CLI
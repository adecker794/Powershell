What these sets of scripts do:
Timecheck.ps1 - Goes to remote computers and pulls the time and the timezone. Used to ensure timezone is set and NTP server is working properly.
Settimezone.ps1 - Remotely sets computer's timezone

Where to place scripts: c:\temp\scripts\timecheck

What to change:
computers.txt - add in your list of computers (used for Timecheck)
computers2.txt - add in your list of computers (used for Settimezone)

Output:
c:\temp\scripts\timecheck\success.csv
c:\temp\scripts\timecheck\failed.csv

How to run:
Open in ISE and run(after defining computers.txt)
Or just run from CLI
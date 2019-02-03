What these sets of scripts do:
These set of scripts will go to a remote computer, send a monitor.ps1 file and pull the information of the connected monitors.
It then sends this information back to the host computer and compiles a list of all the monitors and all the workstations.

Where to place scripts:
c:\temp\scripts\monitor


What to change:
computers.txt - put in your own computers
ID.gpo in c:\temp on remote computers if you want a location of each computer(more info in script\monitor.ps1)

Output:
c:\temp\scripts\monitor\finished\(each computer in the list, it generates an individual file)
c:\temp\scripts\monitor\finished\ALLMONITORS.csv - All files compiled
c:\temp\scripts\monitor\success.csv - What computers were actually reached
c:\temp\scripts\monitor\failed.csv - What computers were unable to be reached.

How to run:
Open in ISE and run(after defining computers.txt)
Or just run from CLI
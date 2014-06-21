getGroups
=========

A script that outputs a list of all the groups a given user, who manages those groups, the e-mail of that manager, and creates a CSV with that information in it. 

USAGE -- getGroups.ps1 [samaccountname]

Where [samaccountname] is the samaccountname of the object with the orphaned group object.

REQUIREMENTS: Powershell 2.0 or above (including in Windows 7 and Windows 8/8.1). Active Directory Users and Computers, or Remote Server Administration Tools

RSAT for Windows 8.1: http://www.microsoft.com/en-us/download/details.aspx?id=39296

RSAT for Windows 8: http://www.microsoft.com/en-us/download/details.aspx?id=28972

RSAT for Windows 7: http://www.microsoft.com/en-us/download/details.aspx?id=7887

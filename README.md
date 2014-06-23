getGroups
=========

A script that outputs a list of all the groups a given user, who manages those groups, the e-mail of that manager, and creates a CSV with that information in it. 

USAGE -- getGroups.ps1 [samaccountname]

Where [samaccountname] is the samaccountname of the object with the orphaned group object.

REQUIREMENTS: Powershell 2.0 or above (including in Windows 7 and Windows 8/8.1). Active Directory Users and Computers, or Remote Server Administration Tools

RSAT for Windows 8.1: http://www.microsoft.com/en-us/download/details.aspx?id=39296

RSAT for Windows 8: http://www.microsoft.com/en-us/download/details.aspx?id=28972

RSAT for Windows 7: http://www.microsoft.com/en-us/download/details.aspx?id=7887

This script was designed to solve a specific problem: when a user is hired to a company and the hiring manager wishes them to have the same security rights and group memberships within the domain as another existing employee, yet authorization must be given for those groups by the group managers, how does a technician quickly and easily generate requests to add the new user to those groups and grant those security permissions in an concise and organized manner when change-management procedures are scrictly enforced. 

This script was eventually turned into a GUI tool that actually generated request e-mails, but this was the back-end script that was doing all the heavy lifting. It does some filtering that is specific to a certain organization, as groups with certain prefixes or characteristics were to be ignored by technicians. The Where-Object statement can be bypassed to eliminate these filters, or the filters can be tailored to your specific organization. 

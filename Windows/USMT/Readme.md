# How to use USMT

## ScanState
* Store all user profiles
  * scanstate.exe <network file location> /i:miguser.xml /i:migapp.xml /o /encrypt /key:"<key>"
  
* Store specific user profile
  * scanstate.exe <network file location> /ui:<domain>\<username> /ue:*\* /i:miguser.xml /i:migapp.xml /o /encrypt /key:"<key>"

## LoadState
* Load saved user profile
  * scanstate.exe <network file location> /i:migapp.xml /i:miguser.xml /decrypt /key:"<key>"

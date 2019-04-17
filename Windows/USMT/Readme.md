# How to use USMT

## ScanState
* Store all user profiles
  * scanstate.exe <store file location> /i:miguser.xml /i:migapp.xml /o /encrypt /key:"<key>"
  
* Store specific user profile
  * .\scanstate.exe <store file location> /ui:<domain>\<username> /ue:*\* /i:miguser.xml /i:migapp.xml /o /encrypt /key:"<key>"

## LoadState

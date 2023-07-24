# Driver organization
https://web.sas.upenn.edu/jasonrw/2016/09/25/mdt-and-drivers/

## Get computer information

wmic computersystem get manufacturer

wmic computersystem get model

## Folder structure

“Windows OS x64\%Make%\%Model%”

## Set Task Sequence Variable

"DriverGroup001"

“Windows OS x64\%Make%\%Model%”

## Inject Drivers

Selection Profile: Nothing

Install all drivers from the selection profile

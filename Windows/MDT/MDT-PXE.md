# Notes on MDT

- Use Deployment Workbench to setup (OS, Drivers, Task Sequence)
- Load Boot image to Windows Deployment Services for the actual PXE implementation

- Seems like some DELL computers default to RAID instead of AHCI for storage, doesn't like PXE boot for whatever reason...
- Might need to enable PXE/Network boot on the imaging device

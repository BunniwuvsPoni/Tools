# How to import/export using OVFTOOL on a VMware ESXi hypervisor

## On Windows
1. Install OVFTOOL from VMware (https://www.vmware.com/support/developer/ovf/)
2. Navigate to the OVFTOOL.EXE directory (C:\Program Files\VMware\VMware OVF Tool\)

## To export a VM
.\ovftool.exe "vi://(ip address of VMware server)/(VM name)" (Directory you want to save the export to)

## To import a VM
.\ovftool.exe (Exported VM ovf file) "vi://(ip address of VMware server)/"

#  Proxmox High Availability Notes.md
- Need at least 3 nodes otherwise in the 2 node scenario, both will try to "activate"

##  Options:
			® Doing it right: CEPH with HA
				□ Networked storage
				□ Nodes all see the same data
				□ Comes at the cost of beefier CPU/RAM/Network requirements
				□ Best in cases of many VMs/CTs or large storage requirements
			® The non-production workaround: ZFS replication with HA
				□ Local machine
				□ Data loss from replication RPO
				□ Best for home lab/non-production use cases

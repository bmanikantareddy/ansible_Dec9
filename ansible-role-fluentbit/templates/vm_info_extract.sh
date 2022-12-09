#!/bin/bash
AVAIL_DOMAIN=$(jq .instance.availabilityDomain /var/log/vminfo | sed 's/"//g')
COMPARTMENT_ID=$(jq .instance.compartmentId /var/log/vminfo | sed 's/"//g')
VM_OCID=$(jq .instance.id /var/log/vminfo | sed 's/"//g')
VM_SHAPE=$(jq .instance.shape /var/log/vminfo | sed 's/"//g')
VM_IP=$(jq .vnics[0].privateIp /var/log/vminfo | sed 's/"//g')
REGION=$(jq .instance.canonicalRegionName /var/log/vminfo | sed 's/"//g')
FAULTDOMAIN=$(jq .instance.faultDomain /var/log/vminfo | sed 's/"//g')
IMAGE_ID=$(jq .instance.image /var/log/vminfo | sed 's/"//g')
VNET_ID=$(jq .vnics[0].vnicId /var/log/vminfo | sed 's/"//g')
SUBNET_CIDR_BLOCK=$(jq .vnics[0].subnetCidrBlock /var/log/vminfo | sed 's/"//g')
HOST_NAME=$(jq .instance.hostname /var/log/vminfo | sed 's/"//g')

sed -i "s/\bavailabilityDomain\b/& $AVAIL_DOMAIN/" /etc/td-agent-bit/td-agent-bit.conf
sed -i "s/\bcompartmentId\b/& $COMPARTMENT_ID/" /etc/td-agent-bit/td-agent-bit.conf
sed -i "s/\binstanceId\b/& $VM_OCID/" /etc/td-agent-bit/td-agent-bit.conf
sed -i "s/\bvm_shape\b/& $VM_SHAPE/" /etc/td-agent-bit/td-agent-bit.conf
sed -i "s/\bhost_ip\b/& $VM_IP/" /etc/td-agent-bit/td-agent-bit.conf
sed -i "s/\boci_region\b/& $REGION/" /etc/td-agent-bit/td-agent-bit.conf
sed -i "s/\bfaultDomain\b/& $FAULTDOMAIN/" /etc/td-agent-bit/td-agent-bit.conf
sed -i "s/\bimageId\b/& $IMAGE_ID/" /etc/td-agent-bit/td-agent-bit.conf
sed -i "s/\bvnic_id\b/& $VNET_ID/" /etc/td-agent-bit/td-agent-bit.conf
sed -i "s:\bsubnet_cidr\b:& $SUBNET_CIDR_BLOCK:" /etc/td-agent-bit/td-agent-bit.conf
sed -i "s/\bhostname\b/& $HOST_NAME/" /etc/td-agent-bit/td-agent-bit.conf
sed -i '/*.* @@remote-host:514/ a *.*  @@10.5.236.52:514' /etc/rsyslog.conf

cat /etc/td-agent-bit/td-agent-bit.conf

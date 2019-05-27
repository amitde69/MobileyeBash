#!/bin/bash


# FUNCTION TO GET ADDRESS FROM API
getservice(){
	serviceips=$(curl -s $catalog'service/'$service 2>/dev/null | jq -r '.[].Address')
        echo $'\n''Service Name:' ${service^^}
	echo 'Service Addresses:' $serviceips$'\n' 
}



# CHECK FOR JQ INSTALLATION
installed=$(dpkg -s jq | grep -o 'installed')
if [[ $installed == 'installed' ]]; then
	echo 'jq exists!!'$'\n'
else
	sudo apt install jq -y
fi

# CONSUL URL
if [[ ${#1} > 0 ]]; then
	catalog=$1	
else
	catalog='http://demo.consul.io/v1/catalog/'
fi

# GET SERVICE NAMES
services=$(curl -s $catalog'services' | jq 'keys | .[]' | sed 's/"//g')

# PRINT SERVICES AND ADDRESSES
for service in $services; do
	getservice
done


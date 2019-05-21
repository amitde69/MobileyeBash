#!/bin/bash


# FUNCTION TO GET ADDRESS FROM API
getservice(){
	serviceips=$(curl -s $catalog'service/'$service | jq '' | grep '"Address"' | awk '{print $2}' | tr --delete '",')
        echo $'\n''Service Name:' ${service^^}
	echo 'Service Addresses:' $serviceips$'\n' 
}



# CHECK FOR JQ INSTALLATION
installed=$(dpkg -s jq | grep -o 'installed')
if [[ $installed == 'installed' ]]; then
	echo 'jq exists!!'$'\n'
else
	sudo apt install jq
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


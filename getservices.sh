#!/bin/bash


# FUNCTION TO GET ADDRESS FROM API
getservice(){
	serviceips=$(curl -s $catalog'service/'$service | jq '' | grep '"Address"' | awk '{print $2}' | tr --delete '",')
        echo $'\n'${service^^}
	echo $serviceips$'\n' 
}



# CHECK FOR JQ INSTALLATION
installed=$(dpkg -s jq | grep -o 'installed')
if [[ $installed == 'installed' ]]; then
	echo 'jq exists!!'$'\n'
else
	sudo apt install jq
fi

# CONSUL URL
catalog="http://demo.consul.io/v1/catalog/"

# GET SERVICE NAMES
services=$(curl -s $catalog'services' | jq 'keys | .[]' | sed 's/"//g')

for service in $services; do
	getservice &
done


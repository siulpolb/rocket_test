#!/bin/bash

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
	echo "usage: source $0 <Deployment Name>"
	exit 1
fi


if [ $# != 1 ]; then
	echo "usage: source $0 <Deployment Name>"
	return 1
fi

kubectl get deployment $1 -o yaml > deployment.yaml

variables=$(yq eval '.spec.template.spec.containers[].env[] | {.name: .value}' deployment.yaml)

while read -r line; do
	var_key=$(grep -o ".*:" <<< $line | grep -o -e "\w\+")
	var_value=$(grep -o ":.*" <<< $line | grep -o -e "\w\+\>")
	export $var_key=$var_value
done <<< $variables

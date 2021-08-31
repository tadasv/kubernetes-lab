#!/bin/bash
set -e

REGISTRY=localhost:5000

command_build() {
	local version=$1
	docker build -t $REGISTRY/k8s-lab-webapp:$version .
}

command_push() {
	local version=$1
	docker push $REGISTRY/k8s-lab-webapp:$version
}

command_apply() {
	kubectl apply -f ./app.yaml
}

command_delete() {
	kubectl delete -f ./app.yaml
}

command_service_node_port() {
	kubectl get service k8s-lab-webapp -o go-template --template='{{ (index .spec.ports 0).nodePort }}'
}

command_cluster_ip() {
	docker network inspect kind | jq '.[0].Containers | .[] | select(.Name=="kind-control-plane") | .IPv4Address ' | sed 's/"//g' | sed 's/\/.*$//'
}

command_service_address() {
	# service address accesible from the host
	echo "$($PWD/$EXE cluster_ip):$($PWD/$EXE service_node_port)"
}

EXE=${0##*/}

while IFS= read -r line; do
	[[ $line =~ ^declare\ -f\ command_ ]] || continue
	COMMANDS+=( "${line##declare -f command_}" )
done < <(declare -F)
mapfile -t COMMANDS < <(LC_COLLATE=C sort < <(printf "%s\n" "${COMMANDS[@]}"))

if [[ -n "$1" ]]; then
	declare cmd="$1"; shift
	"command_$cmd" "$@"
	exit $?
fi

usage() {
	local -a cmds
	for c in "${COMMANDS[@]}"; do
		[[ ${c:0:1} =~ _ ]] && continue
		cmds+=("$c")
	done

	local IFS='|'
	printf "usage: %s (%s)\n" "$EXE" "${cmds[*]}"
}

usage

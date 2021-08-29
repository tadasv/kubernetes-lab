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

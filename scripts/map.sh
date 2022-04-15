#!/bin/bash

source ./scripts/environment.sh

if [[ ! -v SOURCES_DIR || ! -d "${SOURCES_DIR}" ]]; then
	echo -e "\n- Error: ${SOURCES_DIR} directory does not exist."
	echo "-----------------------------"
	exit 1
fi

echo -e "\n- Creating docker-compose mapping"
echo "-----------------------------"

echo "version: '3.9'" > "${DOCKER_MAP_YML}"
{
	echo ""
	echo "services:"
	echo "  joomla:"
	echo "    volumes:"
} >> "${DOCKER_MAP_YML}"

for i in "${!before_installation[@]}"; do
	source="${SOURCES_DIR}/${before_installation[$i]}"
	target="${DOCKER_DIR}/${after_installation[$i]}"
	mount_string="${source}:${target}"
	echo "${mount_string}"
	echo "      - ${mount_string}" >> "${DOCKER_MAP_YML}"
done

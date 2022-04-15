#!/bin/bash

source ./scripts/environment.sh

if [[ ! -v SOURCES_DIR || ! -d "${SOURCES_DIR}" ]]; then
	echo -e "\n- Error: ${SOURCES_DIR} directory does not exist."
	echo "-----------------------------"
	exit 1
fi

rm -rf "${DIST_DIR}"
mkdir "${DIST_DIR}"

#mkdir "${DIST_DIR}/administrator"
#mkdir "${DIST_DIR}/administrator/components"
#mkdir "${DIST_DIR}/administrator/components/${COM_NAME}"
mkdir -p "${DIST_DIR}/administrator/components/${COM_NAME}"

cp -ar "${SOURCES_DIR}/${COM_NAME}/admin/." "${DIST_DIR}/administrator/components/${COM_NAME}"
cp -ar "${SOURCES_DIR}/${COM_NAME}/papermanager.xml" "${DIST_DIR}/administrator/components/${COM_NAME}"

#mkdir "${DIST_DIR}/components"
#mkdir "${DIST_DIR}/components/${COM_NAME}"
mkdir -p "${DIST_DIR}/components/${COM_NAME}"

cp -ar "${SOURCES_DIR}/${COM_NAME}/site/." "${DIST_DIR}/components/${COM_NAME}"

#mkdir "${DIST_DIR}/plugins"
#mkdir "${DIST_DIR}/plugins/content"
#mkdir "${DIST_DIR}/plugins/content/papermanager"
mkdir -p "${DIST_DIR}/plugins/content/papermanager"

cp -ar "${SOURCES_DIR}/${PLG_NAME}/." "${DIST_DIR}/plugins/content/papermanager"

#mkdir "${DIST_DIR}/administrator/manifests"
#mkdir "${DIST_DIR}/administrator/manifests/packages"
mkdir -p "${DIST_DIR}/administrator/manifests/packages"

cp -ar "${SOURCES_DIR}/${PKG_NAME}.xml" "${DIST_DIR}/administrator/manifests/packages"

yes | cp -arf "${DIST_DIR}/." "${JOOMLA_INSTALLATION_DIR}"

echo -e "\n- Files copied to development environment."
echo "-----------------------------"

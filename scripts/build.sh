#!/bin/bash

source ./scripts/environment.sh

if [[ ! -v SOURCES_DIR || ! -d "${SOURCES_DIR}" ]]; then
	echo -e "\n- Error: ${SOURCES_DIR} directory does not exist."
	echo "-----------------------------"
	exit 1
fi

rm -rf "${DIST_DIR}"
mkdir "${DIST_DIR}"

cp -a "${SOURCES_DIR}/${COM_NAME}" "${DIST_DIR}/${COM_NAME}"
cp -a "${SOURCES_DIR}/${PLG_NAME}" "${DIST_DIR}/${PLG_NAME}"
cp -a "${SOURCES_DIR}/${PKG_NAME}.xml" "${DIST_DIR}/${PKG_NAME}.xml"

# Remove ${COM_NAME}/admin/papermanager.xml.
# It may have been copied there when mounting ${COM_NAME}/admin on docker.
# It already exists on ${COM_NAME}/papermanager.xml.
rm -rf "${DIST_DIR}/${COM_NAME}/admin/papermanager.xml"

# Copy index.html to all subdirectories
find "${DIST_DIR}/${COM_NAME}" -type d -not -path "${DIST_DIR}/${COM_NAME}" -exec cp "${DIST_DIR}/${COM_NAME}/index.html" {} \;
find "${DIST_DIR}/${PLG_NAME}" -type d -not -path "${DIST_DIR}/${PLG_NAME}" -exec cp "${DIST_DIR}/${PLG_NAME}/index.html" {} \;

# Compress files to package zip
echo -e "\n- Compressing files to zip"
echo "-----------------------------"
mkdir "${DIST_DIR}/packages"
cd "${DIST_DIR}/${COM_NAME}" && zip -r9 "../packages/${COM_NAME}.zip" . -x \*.swp && cd ../..
cd "${DIST_DIR}/${PLG_NAME}" && zip -r9 "../packages/${PLG_NAME}.zip" . -x \*.swp && cd ../..
# https://github.com/koalaman/shellcheck/wiki/SC2115 -> Use "${var:?}" to ensure this never expands to /*
rm -rf "${DIST_DIR:?}/${COM_NAME:?}"
rm -rf "${DIST_DIR:?}/${PLG_NAME:?}"
cd "${DIST_DIR}" && zip -r9 "${PKG_NAME}-${VERSION}.zip" . -x \*.swp && cd ..
#rm -rf "${DIST_DIR}/packages"
#rm -rf "${DIST_DIR}/${PKG_NAME}.xml"
echo -e "\n- Joomla package can be found in ${DIST_DIR} directory."
echo "-----------------------------"

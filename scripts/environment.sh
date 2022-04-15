#!/bin/bash

export VERSION=0.0.1
export CURRENT_YEAR=$(date +'%Y')

export COM_NAME=com_papermanager
export PLG_NAME=plg_papermanager
export PKG_NAME=pkg_papermanager

export META_CREATION_DATE="2014-04-01"
export META_COPYRIGHT="Copyright (C) 2014 - ${CURRENT_YEAR}. All rights reserved."
export META_LICENSE="GNU General Public License version 2 or later; see LICENSE"
export META_URL="https://papermanager.github.io/"
export META_HEADER_COPYRIGHT_TEXT="/**
 * @package     ${PKG_NAME}
 * @copyright   ${META_COPYRIGHT}
 * @license     ${META_LICENSE}
 * @link        ${META_URL}
 */"

# Can not be used in docker-compose.yml without export
export JOOMLA_INSTALLATION_DIR=./docker/www
export SOURCES_DIR=./src
export DIST_DIR=./dist
export DOCKER_DIR=/var/www/html
export DOCKER_MAP_YML=./docker-compose.map.yml

export before_installation=(
	"${COM_NAME}/admin"
	"${COM_NAME}/papermanager.xml"
	"${COM_NAME}/site"
	"${PLG_NAME}"
	"${PKG_NAME}.xml"
)

export after_installation=(
	"administrator/components/${COM_NAME}"
	"administrator/components/${COM_NAME}/papermanager.xml"
	"components/${COM_NAME}"
	"plugins/content/papermanager"
	"administrator/manifests/packages/${PKG_NAME}.xml"
)

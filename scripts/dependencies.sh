#!/bin/bash

if command -v docker > /dev/null 2>&1; then
	printf "+ 'docker' found: " && docker --version | head -n 1
else
	echo "- 'docker' not found!"
fi

if command -v docker-compose > /dev/null 2>&1; then
	printf "+ 'docker-compose' found: " && docker-compose --version | head -n 1
else
	echo "- 'docker-compose' not found!"
fi

if command -v make > /dev/null 2>&1; then
	printf "+ 'make' found: " && make --version | head -n 1
else
	echo "- 'make' not found!"
fi

if command -v php > /dev/null 2>&1; then
	printf "+ 'php' found: " && php --version | head -n 1
else
	echo "- 'php' not found!"
fi

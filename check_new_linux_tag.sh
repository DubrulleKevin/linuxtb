#!/bin/bash

set -eu

LANG=C

git fetch --all
LAST_TAG="$(git tag --sort=-creatordate | head -1)"
CURRENT_TAG="$(git status | grep "detached at" | cut -d' ' -f4)"
if [ "${LAST_TAG}" != "${CURRENT_TAG}" ]; then
    echo -en "New tag: ${LAST_TAG}\nCheckout? [y/N]: "
    read ANSWER
    if [ "${ANSWER}" == "y" ]; then
        git checkout master
        git pull
        git checkout "${LAST_TAG}"
    fi
else
    echo "No new tag"
fi

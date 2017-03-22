#!/bin/sh
set -e

[[ -z "${NODE_ENV}" ]] && export NODE_ENV='development'

_SECRET=$(cat /private/nodebb/config.json)

if [[ "${NODE_ENV}" = 'development' ]]; then
	_URL='https://forum-staging.antergos.com'
else
	_URL='https://forum.antergos.com'
fi


# Set Config Vars
sed -i "s|<URL>|${_URL}|g;
		s|<SECRET>|${_SECRET}|g" /nodebb/config.json

# Theme
ln -s /theme /nodebb/node_modules/nodebb-theme-antergos

# Give redis some time to come up
sleep 10

{ cd /nodebb && ./nodebb upgrade; } || exit 1

./nodebb dev

exit $?

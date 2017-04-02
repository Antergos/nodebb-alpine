#!/bin/sh
set -e

[[ -z "${NODE_ENV}" ]] && export NODE_ENV='development'

_SECRET=$(cat /run/secrets/nodebb_secret)

if [[ "${NODE_ENV}" = 'development' ]]; then
	_URL='https://forum-staging.antergos.com'
else
	_URL='https://forum.antergos.com'
fi


# Set Config Vars
sed -i "s|<URL>|${_URL}|g;
		s|<SECRET>|${_SECRET}|g" /nodebb/config.json

# Theme
cp -r /theme /nodebb-theme-antergos
mv /nodebb-theme-antergos /nodebb/node_modules

# Give redis some time to come up
sleep 10

{ cd /nodebb && ./nodebb upgrade; } || exit 1

./nodebb dev

exit $?

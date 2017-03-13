#!/bin/sh

# config
cp /private/forum/nodebb/config.json /nodebb

if [[ -z "${NODE_ENV}" || "${NODE_ENV}" = 'development' ]]; then
	sed -i 's|forum|forum-staging|g' /nodebb/config.json
fi

# theme
ln -s /theme /nodebb/node_modules/nodebb-theme-antergos

# Give redis some time to come up
sleep 10

{ cd /nodebb && ./nodebb upgrade; } || exit 1

./nodebb dev

exit $?

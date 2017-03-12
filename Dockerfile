FROM node:alpine
MAINTAINER Antergos Developers <dev@antergos.com>

ARG NODE_ENV

##
# Install Deps
##
RUN apk add --no-cache git \
	&& npm install -g yarn


##
# Build & Install NodeBB
##
RUN git clone --depth=1 https://github.com/nodebb/nodebb \
	&& ln -sf /data/config.json /nodebb/config.json \
	&& cd nodebb \
	&& yarn \
	&& yarn add \
		nodebb-plugin-dbsearch \
		nodebb-plugin-emoji-extended \
		nodebb-plugin-markdown \
		nodebb-plugin-registration-question \
		nodebb-plugin-soundpack-default \
		nodebb-plugin-spam-be-gone \
		nodebb-widget-essentials \
		nodebb-plugin-emailer-mailgun \
		nodebb-plugin-mentions \
		nodebb-plugin-question-and-answer \
		nodebb-plugin-composer-default \
		nodebb-plugin-imgur \
		nodebb-plugin-blog-comments \
		nodebb-plugin-gravatar \
		nodebb-plugin-ns-likes \
		nodebb-plugin-codeinput \
		nodebb-plugin-emoji-apple \
		nodebb-plugin-ns-login \
		nodebb-plugin-poll \
		nodebb-plugin-write-api \
		nodebb-plugin-emoji-static \
		nodebb-plugin-sso-auth0 \
		nodebb-plugin-topic-tags \
		nodebb-theme-antergos


ADD docker-entrypoint.sh /nodebb/
ADD etc /

ENV NODE_ENV production

WORKDIR /nodebb 

VOLUME ["/data"]

EXPOSE 4567

CMD [ "./docker-entrypoint.sh" ]

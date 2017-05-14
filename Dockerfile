FROM node:alpine
MAINTAINER Antergos Developers <dev@antergos.com>

ARG NODE_ENV

##
# Install Deps
##
RUN apk add --no-cache git coreutils

##
# Build & Install NodeBB
##
RUN git clone --branch v1.5.0 https://github.com/nodebb/nodebb /nodebb \
	&& cd /nodebb

ENV NODE_ENV $NODE_ENV

WORKDIR /nodebb 

EXPOSE 4567

CMD [ "/entrypoint/nodebb" ]

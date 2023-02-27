FROM node:erbium-alpine as base

RUN apk --no-cache add git python3 make gcc musl-dev g++ bash
WORKDIR /app/affinity
COPY package*.json ./
RUN npm -v
RUN npm install

FROM node:erbium-alpine as release

COPY --from=base --chown=node:node /app/affinity /app/affinity
WORKDIR /app/affinity
COPY --chown=node:node . .

## Add the wait script to the image
# ADD --chown=node:node https://github.com/ufoscout/docker-compose-wait/releases/download/2.7.3/wait /wait
# RUN chmod +x /wait

USER node
CMD node Cluster.js

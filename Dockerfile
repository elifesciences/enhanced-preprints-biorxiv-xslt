ARG node_version=18.16-slim

# Base stage for building Java app
FROM openjdk:11 as base

RUN apt-get update && apt-get install -y wget libxml2-utils

RUN wget https://repo1.maven.org/maven2/net/sf/saxon/Saxon-HE/10.5/Saxon-HE-10.5.jar \
    && mkdir -p /usr/share/java \
    && mv Saxon-HE-10.5.jar /usr/share/java/saxon.jar

RUN echo "#!/bin/bash\njava -jar /usr/share/java/saxon.jar -s:\$1 -xsl:\$2" > /usr/local/bin/apply-xslt

RUN chmod +x /usr/local/bin/apply-xslt

RUN touch /tmp/JATS-archivearticle1.dtd

FROM base as apply-xslt
ENTRYPOINT ["apply-xslt"]

FROM base as test
WORKDIR /app
COPY . /app
ENTRYPOINT ["/app/project_tests.sh"]

FROM node:${node_version} as node_base
WORKDIR /app
COPY package*.json ./
COPY yarn.lock ./
RUN yarn install
COPY . .
RUN yarn build
RUN yarn install --production

FROM base as api
WORKDIR /app
COPY --from=node_base /usr/local/bin/node /usr/local/bin/
COPY --from=node_base /app/node_modules ./node_modules
COPY --from=node_base /app/dist ./dist
COPY scripts ./scripts
RUN chmod +x -R ./scripts/*
COPY src ./src
ENV PORT 80
CMD [ "node", "dist/server.js" ]

FROM base as prod
WORKDIR /app
COPY scripts ./scripts
RUN chmod +x -R ./scripts/*
COPY src ./src
ENTRYPOINT ["/app/scripts/transform.sh"]

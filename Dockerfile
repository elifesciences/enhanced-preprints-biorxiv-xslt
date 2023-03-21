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

WORKDIR /app

COPY scripts /app/scripts

RUN chmod +x -R /app/scripts/*

COPY src /app/src

FROM base as prod
ENTRYPOINT ["/app/scripts/transform.sh"]

FROM base as test
WORKDIR /app
COPY . /app
ENTRYPOINT ["/app/project_tests.sh"]

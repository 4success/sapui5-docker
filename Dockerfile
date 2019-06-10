FROM nginx:alpine

LABEL maintainer="Renan William Alves de Paula <renan@4success.com.br>"

COPY ./docker/nginx/nginx.conf /etc/nginx/
COPY ./docker/nginx/sites/ /etc/nginx/sites-available/

RUN apk update \
    && apk upgrade \
    && apk add --no-cache openssl \
    && apk add --no-cache bash \
    && adduser -D -H -u 1000 -s /bin/bash www-data

USER root

RUN mkdir /etc/nginx/ssl

ADD ./docker/nginx/startup.sh /opt/startup.sh
RUN sed -i 's/\r//g' /opt/startup.sh
RUN chmod +x /opt/startup.sh

ENTRYPOINT ["/opt/startup.sh"]
EXPOSE 80

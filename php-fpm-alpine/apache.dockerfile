FROM httpd:2.4.33-alpine
# RUN apk update; \
#     apk upgrade;

RUN apk add openssl

RUN openssl req -x509 -nodes -days 365 \
     -subj "/C=CA/ST=QC/O=Company, Inc./CN=localhost" \
    #  -addext "subjectAltName=DNS:localhost" \
     -newkey rsa:2048 -keyout /etc/ssl/private/apache-selfsigned.key \
     -out /etc/ssl/certs/apache-selfsigned.crt

RUN chown -R www-data:www-data /usr/local/apache2/htdocs

# Copy apache vhost file to proxy php requests to php-fpm container
COPY ./conf/apache.conf /usr/local/apache2/conf/demo.apache.conf
RUN echo "Include /usr/local/apache2/conf/demo.apache.conf" \
    >> /usr/local/apache2/conf/httpd.conf

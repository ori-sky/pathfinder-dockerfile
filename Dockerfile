FROM richarvey/nginx-php-fpm:latest
RUN apk add gcc libc-dev autoconf make zeromq-dev
RUN git clone https://github.com/shockkolate/php-zmq.git /tmp/php-zmq; echo | pear install /tmp/php-zmq/package.xml
RUN cd /var/www/html && composer install

ENV PATHFINDER_DB_PASS changeme

RUN sed -i.bak 's/^DB_PF_PASS.*$/DB_PF_PASS = ${PATHFINDER_DB_PASS}/' /var/www/html/app/environment.ini

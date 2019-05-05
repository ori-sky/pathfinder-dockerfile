FROM richarvey/nginx-php-fpm:latest
RUN apk add gcc libc-dev autoconf make zeromq-dev
RUN git clone https://github.com/shockkolate/php-zmq.git /tmp/php-zmq; echo | pear install /tmp/php-zmq/package.xml; docker-php-ext-enable zmq
RUN git clone https://github.com/shockkolate/pathfinder.git /tmp/pathfinder; mv /tmp/pathfinder/* /var/www/html/
RUN git clone https://gist.github.com/shockkolate/6c3bd57c24e22c599bba399a36b6940f /tmp/pathfinder.nginx.conf; mv /tmp/pathfinder.nginx.conf/pathfinder.nginx.conf /etc/nginx/sites-enabled/; rm /etc/nginx/sites-enabled/default.conf
RUN cd /var/www/html && composer install --prefer-dist --no-interaction

#ENV PATHFINDER_URI www.example.com
#ENV PATHFINDER_DB_PASS changeme

#RUN sed -i 's/server_name .*;$/server_name '"${PATHFINDER_URI}"';/' /etc/nginx/sites-enabled/pathfinder.nginx.conf
#RUN sed -i 's/^DB_PF_PASS.*$/DB_PF_PASS = '"${PATHFINDER_DB_PASS}"'/' /var/www/html/app/environment.ini

RUN apk add ruby ruby-dev nodejs npm
RUN gem install compass --no-document

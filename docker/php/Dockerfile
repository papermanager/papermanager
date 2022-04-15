FROM joomla:4.1.2-php8.0-apache

#ENV XDEBUG_PORT 9000
#ENV XDEBUG_CONFIG client_host=host.docker.internal

RUN yes | pecl install xdebug-3.1.4 \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo 'xdebug.mode = develop,debug' >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo 'xdebug.start_with_request = yes' >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo 'xdebug.var_display_max_depth = 5' >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo 'xdebug.var_display_max_children = 256' >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo 'xdebug.var_display_max_data = 1024' >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo 'xdebug.log = /tmp/xdebug.log' >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo 'xdebug.log_level = 7' >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo 'xdebug.client_host = host.docker.internal' >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo 'xdebug.client_port = 9000' >> /usr/local/etc/php/conf.d/xdebug.ini

EXPOSE 9000

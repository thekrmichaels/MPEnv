ARG PHP_VERSION=8.5

FROM php:${PHP_VERSION}-apache

# Update and install packages, Composer, Node.js, clean up and enable Apache module rewrite.
RUN apt-get update && apt-get install -y curl git gnupg unzip && \
    docker-php-ext-install mysqli pdo pdo_mysql && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    curl -fsSL https://deb.nodesource.com/setup_24.x | bash - && \
    apt-get install -y nodejs && \
    a2enmod rewrite && \
    rm -rf /var/lib/apt/lists/*

# Add Composer global directory to PATH
ENV PATH=/root/.composer/vendor/bin:$PATH

WORKDIR /var/www/html

COPY /src /var/www/html

# Set permissions for copied files, configure Apache server name and permissions.
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html && \
    echo 'ServerName localhost' > /etc/apache2/conf-available/servername.conf && \
    a2enconf servername && \
    sed -i '/#Include conf-available\/serve-cgi-bin.conf/a \
    \ \ \ \ <Directory /var/www/html>\n\
    \ \ Options Indexes FollowSymLinks\n\
    \ \ AllowOverride All\n\
    \ \ Require all granted\n\
    </Directory>' /etc/apache2/sites-available/000-default.conf

EXPOSE 80

CMD ["apache2-foreground"]

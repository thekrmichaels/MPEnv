ARG PHP_VERSION=8.4

FROM php:${PHP_VERSION}-apache

# Install (and update) packages, Node.js, clean up, install Composer, and enable Apache module rewrite.
RUN apt-get update && \
    docker-php-ext-install mysqli pdo pdo_mysql && \
    apt-get install -y curl git gnupg unzip && \
    curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install -y nodejs && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    a2enmod rewrite && \
    rm -rf /var/lib/apt/lists/*

# Add Composer global directory to PATH
ENV COMPOSER_HOME=/root/.composer
ENV PATH=$COMPOSER_HOME/vendor/bin:$PATH

WORKDIR /var/www/html

COPY /src /var/www/html

# Set permissions for copied files, configure Apache server name and permissions.
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html && \
    echo 'ServerName localhost' > /etc/apache2/conf-available/servername.conf && \
    a2enconf servername && \
    echo '<Directory /var/www/html>\n\
    Options Indexes FollowSymLinks\n\
    AllowOverride All\n\
    Require all granted\n\
    </Directory>' > /etc/apache2/sites-available/000-default.conf

EXPOSE 80

CMD ["apache2-foreground"]

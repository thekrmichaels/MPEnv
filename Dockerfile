ARG PHP_VERSION=8.4.6

FROM php:${PHP_VERSION}-apache

# Install PHP extensions, update package lists, install additional packages (unzip, git), clean up, install Composer, and enable Apache module rewrite.
RUN docker-php-ext-install mysqli pdo pdo_mysql && \
    apt-get update && \
    apt-get install -y unzip git && \
    rm -rf /var/lib/apt/lists/* && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    a2enmod rewrite

# Add Composer global directory to PATH
ENV COMPOSER_HOME=/root/.composer
ENV PATH=$COMPOSER_HOME/vendor/bin:$PATH

WORKDIR /var/www/html

# Copy source files from the host to the image.
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

# Expose port 80 for the application.
EXPOSE 80

# Run Apache in the foreground.
CMD ["apache2-foreground"]

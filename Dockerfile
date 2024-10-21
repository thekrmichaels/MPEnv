ARG PHP_VERSION=8.4.1

FROM php:${PHP_VERSION}-apache

# Install PHP extensions.
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Update package lists, install additional packages (unzip, git), and clean up.
RUN apt-get update && \
    apt-get install -y unzip git && \
    rm -rf /var/lib/apt/lists/*

# Install Composer.
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Enable Apache module rewrite.
RUN a2enmod rewrite

WORKDIR /var/www/html

# Copy source files from the host to the image.
COPY /src /var/www/html

# Set file permissions for the copied files.
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

# Configure Apache server name.
RUN echo 'ServerName localhost' > /etc/apache2/conf-available/servername.conf && \
    a2enconf servername

# Explicit configuration of permissions in Apache.
RUN echo '<Directory /var/www/html>\n\
    Options Indexes FollowSymLinks\n\
    AllowOverride All\n\
    Require all granted\n\
    </Directory>' > /etc/apache2/sites-available/000-default.conf

# Expose port 80 for the application.
EXPOSE 80

# Run Apache in the foreground.
CMD apache2-foreground

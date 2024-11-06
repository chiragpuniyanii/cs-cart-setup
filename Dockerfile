FROM php:8.1-apache

# Install necessary PHP extensions and system dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libfreetype6-dev \
    libzip-dev zlib1g-dev \
    libxml2-dev \
    libcurl4-openssl-dev \
    imagemagick libmagickwand-dev --no-install-recommends \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql zip curl sockets exif soap \
    && pecl install imagick \
    && docker-php-ext-enable imagick

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Set the working directory
WORKDIR /var/www/html

# Copy CS-Cart files into the container
COPY . .

# Set permissions
RUN chown -R www-data:www-data /var/www/html

FROM php:8.2-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libonig-dev libxml2-dev zip unzip curl git npm nodejs sqlite3 \
    && docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www

# Copy composer files first for layer caching
COPY composer.json composer.lock ./

# Create log directory (used for debugging Laravel errors)
RUN mkdir -p /var/www/storage/logs

# Install PHP dependencies (with error fallback log output)
RUN composer install --no-interaction --prefer-dist --optimize-autoloader || cat /var/www/storage/logs/laravel.log || true

# Now copy the rest of the app
COPY . .

# Expose Laravel development port
EXPOSE 8000

# Start Laravel dev server
CMD php artisan serve --host=0.0.0.0 --port=8000

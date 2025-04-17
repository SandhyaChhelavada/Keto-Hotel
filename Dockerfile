FROM php:8.2-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libonig-dev libxml2-dev zip unzip curl git npm nodejs sqlite3 \
    && docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www

# Copy project files
COPY . .

# Set permissions
RUN chmod -R 755 /var/www

# Install PHP packages
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Generate Laravel APP key (Render can do this too)
RUN cp .env.example .env && php artisan key:generate

# Laravel uses public directory
EXPOSE 8000

# Start Laravel server (only for testing — not for real production)
CMD php artisan serve --host=0.0.0.0 --port=8000

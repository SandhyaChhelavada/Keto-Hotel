FROM php:8.2-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libonig-dev libxml2-dev zip unzip curl git npm nodejs sqlite3 \
    && docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www

# Copy composer files first for caching
COPY composer.json composer.lock ./

# Install dependencies first
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Now copy the rest of the app
COPY . .

# Set permissions
RUN chmod -R 755 /var/www

# Only copy .env if not using Render env vars
# Remove this if Render sets env in the dashboard
# RUN cp .env.example .env && php artisan key:generate

# Expose port and start Laravel dev server
EXPOSE 8000
CMD php artisan serve --host=0.0.0.0 --port=8000

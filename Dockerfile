# Imagen base oficial de PHP con Composer
FROM php:8.2-cli

# Instala dependencias necesarias para Laravel y GD
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zip \
    unzip \
    git \
    curl \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    && docker-php-ext-install gd pdo pdo_mysql zip

# Instala Composer desde imagen oficial
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Establece directorio de trabajo
WORKDIR /var/www

# Copia todo el proyecto al contenedor
COPY . .

# Instala dependencias de Laravel
RUN composer install --optimize-autoloader --no-interaction --no-scripts

# Expone el puerto 8080 para Railway
EXPOSE 8080

# Comando para iniciar Laravel
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8080"]
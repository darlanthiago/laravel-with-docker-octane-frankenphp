FROM dunglas/frankenphp

# add additional extensions here:
RUN install-php-extensions \
	pcntl \
	pdo_mysql \
	curl \
	zip 

COPY . /app

# Install composer
COPY --from=composer/composer:2 /usr/bin/composer /usr/local/bin/composer

RUN composer install --prefer-dist --no-scripts --no-dev --no-autoloader

RUN composer dump-autoload --no-interaction --no-dev --optimize


RUN chmod -R 775 storage
RUN chmod -R 775 bootstrap


CMD php artisan migrate

EXPOSE 80

ENTRYPOINT ["php", "artisan", "octane:frankenphp"]
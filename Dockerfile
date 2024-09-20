FROM dunglas/frankenphp

# add additional extensions here:
RUN install-php-extensions \
	pcntl \
	pdo_mysql

COPY . /app

RUN curl -sS https://getcomposer.org/installer | php -- \
	--install-dir=/usr/bin --filename=composer

RUN chmod -R 775 storage
RUN chmod -R 775 bootstrap

CMD php artisan migrate

ENTRYPOINT ["php", "artisan", "octane:frankenphp"]
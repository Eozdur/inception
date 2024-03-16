FROM debian:bullseye

RUN apt-get update && apt-get install -y php-fpm php-mysql sendmail wget
#php-fpm, php-mysql ve sendmail paketlerini yükler
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp-cli
#wp-cli.phar dosyasını indirir, çalıştırılabilir hale getirir ve /usr/local/bin dizinine taşır

EXPOSE 9000
#9000 portunu açar

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/
#host makinede bulunan www.conf dosyasının container içindeki /etc/php/7.4/fpm/pool.d dizinine kopyalanması
COPY ./tools/wp.sh /
#host makinede bulunan wp.sh dosyasının container içindeki /var/www dizinine kopyalanması
RUN chmod +x /wp.sh
#wp.sh dosyasının çalıştırılabilir hale getirilmesi
ENTRYPOINT [ "/wp.sh" ]
#wp.sh dosyasının container çalıştırıldığında çalıştırılması
CMD [ "/usr/sbin/php-fpm7.4", "--nodaemonize" ]
#php-fpm7.4 --nodaemonize komutunun container çalıştırıldığında çalıştırılması. Bu komut php-fpm'in arka planda çalışmasını sağlar.
```
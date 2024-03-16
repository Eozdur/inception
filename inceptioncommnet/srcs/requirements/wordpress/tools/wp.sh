#!/bin/bash
#WP-CLI, WordPress komut satırı arayüzü anlamına gelir. 
#WordPress sitelerini yönetmek için komut satırı arayüzü sağlayan bir araçtır. Bu araç, geliştiricilerin ve sistem yöneticilerinin WordPress sitelerini kurmak, yapılandırmak, 
#güncellemek ve yönetmek için kullanabilecekleri bir dizi komut sunar


chown -R www-data: /var/www/*;
#chown -R www-data: /var/www/*; komutu /var/www dizini altındaki tüm dosyaların ve dizinlerin sahibini www-data kullanıcısı yapar.
chmod -R 755 /var/www/*;
#chmod -R 755 /var/www/*; komutu /var/www dizini altındaki tüm dosyaların ve dizinlerin izinlerini ayarlar. 755 izinleri, dosya sahibine okuma, yazma ve çalıştırma izinleri verir.
mkdir -p /run/php/;
#mkdir -p /run/php/; komutu /run/php/ dizinini oluşturur.
touch /run/php/php7.4-fpm.pid;
#touch /run/php/php7.4-fpm.pid; komutu /run/php/ dizini altında php7.4-fpm.pid adında bir dosya oluşturur.  

if [ ! -f /var/www/html/wp-config.php ]; then
#Eğer /var/www/html dizini altında wp-config.php adında bir dosya yoksa
    mkdir -p /var/www/html;
    #mkdir -p /var/www/html; komutu /var/www/html dizinini oluşturur.
    cd /var/www/html;
    #cd /var/www/html; komutu /var/www/html dizinine geçer.

    wp-cli core download --allow-root;
    #wp-cli core download --allow-root; komutu WordPress'in en son sürümünü indirir.

    wp-cli config create --allow-root \
    #wp clı aracını kullanarak wp-config.php dosyasını oluşturuyoruz
    #bilgileri burada belirtiyoruz
        --dbname=$MYSQL_DATABASE_NAME \
        --dbuser=$MYSQL_USER \
        --dbpass=$MYSQL_PASSWORD \
        --dbhost=mariadb;

    echo "WordPress installation has started. Wait until the installation is completed."

    wp-cli core install --allow-root \
    #wp clı aracını kullanarak wordpress kurulumunu yapıyoruz
        --url=$DOMAIN_NAME \
        --title=$TITLE \
        --admin_user=$WORDPRESS_ADMIN_NAME \
        --admin_password=$WORDPRESS_ADMIN_PASSWORD \
        --admin_email=$WORDPRESS_ADMIN_EMAIL;

    wp-cli user create --allow-root \
    #wp clı aracını kullanarak kullanıcı oluşturuyoruz
        $MYSQL_USER $MYSQL_EMAIL \
        --user_pass=$MYSQL_PASSWORD;
fi

echo "You can visit $DOMAIN_NAME in your browser."

exec "$@"
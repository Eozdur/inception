#!/bin/bash

service mariadb start
#maria db servisini başlatıyoruz

sleep 3
#3 saniye bekliyoruz çünkü maria db servisi başlatıldıktan sonra bir süre geçmesi gerekiyor
mariadb -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE_NAME;"
#mariadb -e mariadb için sql komutlarını çalıştırmak için kullanılır
#-e hemen ardından gelen sql komutlarını çalıştırır
mariadb -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
mariadb -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE_NAME.* TO '$MYSQL_USER'@'%';"
mariadb -e "FLUSH PRIVILEGES;"
mariadb -e "SHUTDOWN;"

exec "$@"
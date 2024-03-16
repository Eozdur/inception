# i dont know yet buster or bullseye 
FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server
#mariadb-server paketini yükler
EXPOSE 3306
#3306 portunu açar
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
#host makinede bulunan 50-server.cnf dosyasının container içindeki /etc/mysql/mariadb.conf.d dizinine kopyalanması
COPY ./tools/dbstart.sh /
#host makinede bulunan dbstart.sh dosyasının container içindeki /var/www dizinine kopyalanması
RUN chmod +x /dbstart.sh
#dbstart.sh dosyasının çalıştırılabilir hale getirilmesi
ENTRYPOINT [ "/dbstart.sh" ]
#dbstart.sh dosyasının container çalıştırıldığında çalıştırılması
CMD [ "mariadbd" ]
#mariadbd komutunun container çalıştırıldığında çalıştırılması. Bu komut mariadb-server'in arka planda çalışmasını sağlar.
#kurulacak işletim sistemi
FROM debian:bullseye 

RUN apt-get update && apt-get install -y nginx openssl
#nginx ve openssl paketlerini yükler
EXPOSE 443
#443 portunu açar
COPY ./conf/default /etc/nginx/sites-enabled/
#host makinede bulunan default dosyasının container içindeki default dosyasına kopyalanması
COPY ./tools/nxstart.sh /
#host makinede bulunan nginx_start.sh dosyasının container içindeki /var/www dizinine kopyalanması
RUN chmod +x /nxstart.sh
#nginx_start.sh dosyasının çalıştırılabilir hale getirilmesi
ENTRYPOINT [ "/nxstart.sh" ]
#nginx_start.sh dosyasının container çalıştırıldığında çalıştırılması
CMD [ "nginx", "-g", "daemon off;" ]
#nginx -g daemon off; komutunun container çalıştırıldığında çalıştırılması. Bu komut nginx'in arka planda çalışmasını sağlar.
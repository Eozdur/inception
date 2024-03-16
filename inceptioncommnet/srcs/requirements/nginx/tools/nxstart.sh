#!/bin/bash

echo "server { "  >> /etc/nginx/sites-enabled/default
echo "	listen 443 ssl;"  >> /etc/nginx/sites-enabled/default
echo "	listen [::]:443 ssl;"  >> /etc/nginx/sites-enabled/default
echo "	server_name $DOMAIN_NAME;"  >> /etc/nginx/sites-enabled/default

echo "	ssl_certificate $CERTIFICICATES_OUT; "  >> /etc/nginx/sites-enabled/default
echo "	ssl_certificate_key $CERTIFICICATES_KEYOUT; "  >> /etc/nginx/sites-enabled/default
echo "	ssl_protocols TLSv1.3;"  >> /etc/nginx/sites-enabled/default

echo "	root /var/www/html;"  >> /etc/nginx/sites-enabled/default

echo "	index index.php;"  >> /etc/nginx/sites-enabled/default

echo '        location / {'  >> /etc/nginx/sites-enabled/default
echo '                try_files $uri $uri/ =404;'  >> /etc/nginx/sites-enabled/default
echo '        }'  >> /etc/nginx/sites-enabled/default
 
echo "	location ~ \.php$ { "  >> /etc/nginx/sites-enabled/default
echo "		include snippets/fastcgi-php.conf;"  >> /etc/nginx/sites-enabled/default
echo "		fastcgi_pass $MYSQL_DATABASE_NAME:9000;"  >> /etc/nginx/sites-enabled/default
echo "		proxy_connect_timeout 300s; "  >> /etc/nginx/sites-enabled/default
echo "		proxy_send_timeout 300s; "  >> /etc/nginx/sites-enabled/default
echo "		proxy_read_timeout 300s; "  >> /etc/nginx/sites-enabled/default
echo "		fastcgi_send_timeout 300s; "  >> /etc/nginx/sites-enabled/default
echo "		fastcgi_read_timeout 300s; " >> /etc/nginx/sites-enabled/default
echo "	} "  >> /etc/nginx/sites-enabled/default
echo "}" >> /etc/nginx/sites-enabled/default

if [ ! -f $CERTIFICICATES_OUT ]; then # If certificate file does not exist
#bu kısımda sertifika oluşturuluyor
    openssl req \
#bu req 2048 bitlik rsa algoritmasını kullanarak sertifika oluşturuyor
    -newkey rsa:2048 \
#özel anahtar şifrelenmez
    -nodes \
#-keyoout özel anahtarın nereye kaydedileceğini belirtir
    -keyout $CERTIFICICATES_KEYOUT \
#-x509 sertifika oluşturur
    -x509 \
#-days sertifikanın ne kadar süreyle geçerli olacağını belirtir
    -days 365 \
#-out sertifikanın nereye kaydedileceğini belirtir
    -out $CERTIFICICATES_OUT \
#-subj sertifika bilgilerini belirtir
    -subj "/C=TR/ST=KOCAELI/L=GEBZE/O=42Kocaeli/CN=$DOMAIN_NAME";
fi

exec "$@"
#exec "$@" // exec "$@" satırı, bir shell scriptin son satırıdır ve scriptin çalıştırılmasını sağlar. $@ değişkeni, scripte verilen tüm argümanları içerir. exec komutu, mevcut shell işlemini sonlandırarak verilen komutu çalıştırır. 
#Yani exec "$@", shell scriptin sonlandırılmasına ve scripte verilen argümanların kullanılarak bir komutun çalıştırılmasına yol açar. 
#Bu sayede, script sonlandırılmadan önce son komutun çıkışı (exit status) scriptin çıkışı olarak kullanılır. 
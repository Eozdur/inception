all:
	@mkdir -p /home/eozdur/data/wordpress
	@mkdir -p /home/eozdur/data/mariadb
	@docker-compose -f srcs/docker-compose.yml up --build

start:
	@docker-compose -f srcs/docker-compose.yml start
#-f bayrağı ile dosya belirtiyoruz. docker-compose.yml dosyasını belirttik.
stop:
	@docker-compose -f srcs/docker-compose.yml stop

clean:
	@docker-compose -f srcs/docker-compose.yml down --volumes

fclean: clean
#docker system prune -af komutu ile tüm container, image, network ve volume'leri siliyoruz.
#af bayrağı ile tüm verileri siler. -a bayrağı ile tüm verileri siler. -f bayrağı ile onaylamadan siler.	
	@docker system prune -af
	@rm -rf /home/eozdur/data

.PHONY: all start stop clean fclean re
# encrypt mail
# https://doc.dovecot.org/configuration_manual/mail_crypt_plugin/#ec-key
docker volume create dms-config-custom-volume
docker cp /host_dir mycontainer:/container_dir
docker volume create website-volume
docker volume create ngnix-config-volume
docker-compose run mailserver openssl ecparam -name prime256v1 -genkey | openssl pkey -out /certs/ecprivkey.pem
docker-compose run mailserver openssl pkey -in /certs/ecprivkey.pem -pubout -out /certs/ecpubkey.pem

# setup mailserver
echo "creating it-admin@johnston.host"
docker-compose run mailserver setup email add it-admin@johnston.host
docker-compose run mailserver setup email list
docker-compose run mailserver setup alias add postmaster@johnston.host it-admin@johnston.host
docker-compose run mailserver setup alias list
docker-compose run mailserver setup config dkim

docker-compose up -d
docker-compose run mailserver cat /tmp/docker-mailserver/opendkim/keys/johnston.host/mail.txt
docker-compose logs -f

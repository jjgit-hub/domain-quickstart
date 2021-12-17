# setup traefik letsencrypt
sudo mkdir -p ./docker-data/traefik/
sudo touch ./docker-data/traefik/acme.json
sudo chmod 600 ./docker-data/traefik/acme.json

# encrypt mail
https://doc.dovecot.org/configuration_manual/mail_crypt_plugin/#ec-key
sudo mkdir -p ./docker-data/dms/certs/
openssl ecparam -list_curves
openssl ecparam -name prime256v1 -genkey | openssl pkey -out ./docker-data/dms/certs/ecprivkey.pem
openssl pkey -in ecprivkey.pem -pubout -out ./docker-data/dms/certs/ecpubkey.pem

# setup mailserver
docker-compose run mailserver setup email add it-admin@example.com
docker-compose run mailserver setup email list
docker-compose run mailserver setup alias add postmaster@example.com it-admin
docker-compose run mailserver setup alias list
docker-compose run mailserver setup config dkim

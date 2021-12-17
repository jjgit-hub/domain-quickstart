# setup traefik letsencrypt
sudo mkdir -p ./docker-data/traefik/
sudo touch ./docker-data/traefik/acme.json
sudo chmod 600 ./docker-data/traefik/acme.json

# encrypt mail
# https://doc.dovecot.org/configuration_manual/mail_crypt_plugin/#ec-key
sudo mkdir -p ./docker-data/dms/certs/
sudo openssl ecparam -list_curves
sudo openssl ecparam -name prime256v1 -genkey | sudo openssl pkey -out ./docker-data/dms/certs/ecprivkey.pem
sudo openssl pkey -in ./docker-data/dms/certs/ecprivkey.pem -pubout -out ./docker-data/dms/certs/ecpubkey.pem

# setup mailserver
echo "creating it-admin@example.com"
docker-compose run mailserver setup email add it-admin@example.com
docker-compose run mailserver setup email list
docker-compose run mailserver setup alias add postmaster@example.com it-admin
docker-compose run mailserver setup alias list
docker-compose run mailserver setup config dkim

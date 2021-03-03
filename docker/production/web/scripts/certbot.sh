certbot certonly \
	--webroot -w /var/www/app/public \
	-d "chutedobrasileirao.com.br" \
	-d "www.chutedobrasileirao.com.br" \
	--email "pedrogglima@gmail.com" \
	--rsa-key-size 4096 \
	--agree-tos \
	--expand \
	--noninteractive \
	--debug-challenges \
	$OPTIONS || true

if [[ -f "/etc/letsencrypt/live/chutedobrasileirao.com.br/privkey.pem" ]]; then
    cp "/etc/letsencrypt/live/chutedobrasileirao.com.br/privkey.pem" /usr/share/nginx/certificates/privkey.pem
		cp "/etc/letsencrypt/live/chutedobrasileirao.com.br/fullchain.pem" /usr/share/nginx/certificates/fullchain.pem
fi
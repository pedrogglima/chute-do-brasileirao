FROM nginx

LABEL maintainer="pedrogglima"

# Install dependencies
RUN apt-get update -qq && apt-get -y install apache2-utils inotify-tools certbot openssl

# Create the folders if necessary and set working directory inside the image 
WORKDIR /var/www/app
RUN mkdir log
RUN mkdir public
COPY public public/

# Set up Nginx with certbot setup
WORKDIR /opt
COPY docker/production/web/scripts/entrypoint.sh nginx-letsencrypt
COPY docker/production/web/scripts/certbot.sh certbot.sh
COPY docker/production/web/ssl-options/ /etc/ssl-options
COPY docker/production/web/nginx.conf /etc/nginx/conf.d/default.conf

RUN chmod +x nginx-letsencrypt && \
  chmod +x certbot.sh 

ENTRYPOINT ["./nginx-letsencrypt"]
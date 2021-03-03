FROM nginx

LABEL maintainer="pedrogglima"

# Install dependencies
RUN apt-get update -qq && apt-get -y install apache2-utils

# Create the folders if necessary and set working directory inside the image 
WORKDIR /var/www/app
RUN mkdir log
RUN mkdir public
COPY public public/

COPY docker/staging/web/nginx.conf /etc/nginx/conf.d/default.conf

# Use the "exec" form of CMD so Nginx shuts down gracefully on SIGTERM (i.e. `docker stop`)
CMD [ "nginx", "-g", "daemon off;" ]
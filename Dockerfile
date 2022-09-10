FROM amazonlinux:latest
MAINTAINER Charfeddine SAHLI

# Install dependencies
RUN apt-get update -y && \
    apt-get update httpd && \
    
# copy index.html file into html directory
COPY index.html /var/www/html

# exposes port 80 on the container
EXPOSE 80

# Set the default application that will start when container starts
ENTRYPOINT ["/usr/sbin/httpd", "-D", "FOREGROUND"]


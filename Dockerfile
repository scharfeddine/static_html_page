FROM amazonlinux:latest
MAINTAINER Charfeddine SAHLI

# Installing Apache
RUN yum update -y && \
    yum update httpd -y && \
    yum install httpd -y

# copy index.html file into html directory
COPY index.html /var/www/html

# exposes port 80 on the container
EXPOSE 80

# Set the default application that will start when container starts
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

# container build timestamp
RUN date >/build-date.txt


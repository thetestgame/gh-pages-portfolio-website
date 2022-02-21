# Start from a Apache based PHP base image to serve our build website files
FROM php:7.0-apache

# Allow overrides in Apache2
RUN echo "<Directory /var/www>\nOptions +Indexes\nAllowOverride All\nOrder allow,deny\nAllow from all\n</Directory>" >> /etc/apache2/apache2.conf &&\
    a2enmod rewrite &&\
    a2dissite 000-default &&\
    service apache2 restart

# Install our dependencies
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y git && apt-get install -y software-properties-common
RUN apt-get install -y python-pip python-dev ruby-full build-essential
RUN pip install --upgrade pip
RUN apt-get install -y vim

# Install jekyll and run build
RUN gem install jekyll bundler
RUN bundler exec jekyll build

# Copy the built site into the Apache directory
COPY _site /var/www/html
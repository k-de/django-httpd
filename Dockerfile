# Clone and decompress mod_wsgi package
FROM alpine:latest AS setup

RUN apk update && apk add --no-cache git

WORKDIR /usr/src/setup

# git clone the mod_wsgi archive
RUN git clone https://github.com/GrahamDumpleton/mod_wsgi/archive/4.7.1.tar.gz

# extract the archive
RUN tar xvfz mod_wsgi-4.7.1.tar.gz

# copy installation script
COPY install_mod_wsgi.sh .

# enable execute permissions on the script
RUN chmod +x install_mod_wsgi.sh

##################
# build, install, clean
FROM alpine:latest AS build

# update repo
RUN apk update

# set the working directory to /build
WORKDIR /build

# copy the contents from /usr/src/setup (from the prev. stage) into /build
COPY --from=setup /usr/src/setup .

# run installation script
RUN ./install_mod_wsgi.sh

##################
FROM httpd:alpine

RUN apk update && apk add --no-cache python3

WORKDIR /usr/local/apache2

# copy compiled file to /usr/local/apache2/modules
COPY --from=build /mod-wsgi/.lib/mod_wsgi.so ./modules

# load module by appending the output from echo to httpd.conf
RUN echo -e '\nLoadModule wsgi_module modules/mod_wsgi.so' >> usr/local/apache2/httpd.conf

# restart apache2 service
CMD [“apachectl”, “-D FOREGROUND”]

# container will listen on port 80
EXPOSE 80

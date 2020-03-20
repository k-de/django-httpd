#! /bin/bash

###########################################
# Installation script for mod_wsgi version 4.7.1.

## mod_wsgi documentation:
## https://modwsgi.readthedocs.io/en/develop/user-guides/quick-installation-guide.html

## mod_wsgi github page:
## https://github.com/GrahamDumpleton/mod_wsgi/releases
###########################################

# cd into cloned project
echo 'Starting installation script...'
cd mod_wsgi-4.7.1 

# run the "configure" script
echo 'Running the congifure script...'
./configure
echo 'DONE.'

# build the package
echo 'Building the package...'
make
echo 'DONE.'

# install the module
echo 'Installing the module...'
make install
echo 'DONE.'

# clean up
echo 'Cleaning up after the build'
make clean
echo 'DONE'

echo 'Exiting this script.'


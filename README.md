## PHP7-FPM & Nginx Docker Image
Lightwight Docker image for the XunSearch based on Centos:7

Image size only ~100MB !

Very new packages (centos:7):

XunSearch 1.4.10

## Usage

sudo docker run -p 8383:8383 -p 8384:8384 -v /local/xunsearch/data:/usr/local/xunsearch/data --name xunsearch davinbao/xunsearch

## Volume structure

data: /usr/local/xunsearch/data

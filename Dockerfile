FROM ubuntu:22.04

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install nginx && \
    apt-get clean && \
    rm -fr /var/www/* && \
    mkdir /var/www/my_project && \
    mkdir /var/www/my_project/img

COPY index.html /var/www/my_project/ 
COPY img.jpg /var/www/my_project/img/

RUN chmod -R u+rwx,go+rx /var/www/my_project
RUN useradd denis 
RUN chown -R denis:denis /var/www/my_project
RUN sed -i 's|/var/www/html|/var/www/my_project|g' /etc/nginx/sites-enabled/default && \
    sed -i 's|user www-data|user denis|g' /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

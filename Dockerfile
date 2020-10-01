FROM ubuntu
ENV UBUNTU_HOME=/var/www/html/
RUN apt-get update -y
RUN apt-get install apache2 -y
WORKDIR UBUNTU_HOME
COPY script/ ${UBUNTU_HOME}
EXPOSE 80
CMD ["apachectl" , "-D","FOREGROUND"]

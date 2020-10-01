FROM ubuntu
ENV UBUNTU_HOME=/var/www/html/
RUN apt-get update -y
RUN apt-get install apache2 -y
RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata
WORKDIR UBUNTU_HOME
COPY script/ ${UBUNTU_HOME}
EXPOSE 80
CMD ["apachectl" , "-D","FOREGROUND"]

#docker run -itd -p 27017:27017 -v /home/ravindra/mongo-data:/data/db mongo

FROM ubuntu
ENV UBUNTU_HOME=/var/www/html/
RUN apt-get update -y
RUN apt-get install apache2 -y
RUN apt-get install -y tzdata
WORKDIR UBUNTU_HOME
ADD http://www.java2s.com/Code/JarDownload/json-simple/json-simple-1.1-bundle.jar.zip /tmp
COPY script/ ${UBUNTU_HOME}
EXPOSE 80
CMD ["apachectl" , "-D","FOREGROUND"]

#docker run -itd -p 27017:27017 -v /home/ravindra/mongo-data:/data/db mongo

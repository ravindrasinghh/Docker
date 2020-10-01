FROM ubuntu
ENV UBUNTU_HOME=/var/www/html/
RUN apt-get update -y
RUN apt-get install apache2 -y
WORKDIR UBUNTU_HOME
ADD http://www.java2s.com/Code/JarDownload/json-simple/json-simple-1.1-bundle.jar.zip /tmp
COPY script/ ${UBUNTU_HOME}
RUN apt-get install nodejs -y
RUN npm install -g @angular/cli@8.3.6
RUN apt install maven -y
RUN apt install git -y
EXPOSE 80
CMD ["apachectl" , "-D","FOREGROUND"]

#docker run -itd -p 27017:27017 -v /home/ravindra/mongo-data:/data/db mongo

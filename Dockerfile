FROM ubuntu
ENV UBUNTU_HOME=/var/www/html/
RUN apt-get update -y
RUN apt-get install apache2 -y
RUN apt-get install -y tzdata
ENV TZ=Europe/Kiev
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update && apt install -y python-pip python-dev ssh python-boto3
ENV DEBIAN_FRONTEND noninteractive
ENV TZ=Europe/Moscow
WORKDIR UBUNTU_HOME
ADD http://www.java2s.com/Code/JarDownload/json-simple/json-simple-1.1-bundle.jar.zip /tmp
COPY script/ ${UBUNTU_HOME}
EXPOSE 80
CMD ["apachectl" , "-D","FOREGROUND"]

#docker run -itd -p 27017:27017 -v /home/ravindra/mongo-data:/data/db mongo

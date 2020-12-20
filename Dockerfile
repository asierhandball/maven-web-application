# Pull base image 
From tomcat:8-jre8 

# Maintainer 
MAINTAINER "asaluena@unizar.es" 
COPY ./webapp.war /usr/local/tomcat/webapps

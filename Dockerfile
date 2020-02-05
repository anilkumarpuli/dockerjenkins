FROM tomcat:8-jre8
RUN rm -rf /usr/local/tomcat/webapps/*
COPY target/*.war  /usr/local/tomcat/webapps/ROOT.war
CMD ["catalinaa.sh","run"]
EXPOSE 8080

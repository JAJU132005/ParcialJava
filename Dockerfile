FROM tomcat:8.5.96

WORKDIR /usr/local/tomcat/webapps
COPY ./parcial2doCorte /usr/local/tomcat/webapps/
COPY ./WEB-INF/lib/javax.servlet.jsp.jstl-1.2.1.jar /usr/local/tomcat/lib/
COPY ./WEB-INF/lib/mysql-connector-java-5.1.12-bin.jar /usr/local/tomcat/lib/

# Expone el puerto 8080
EXPOSE 8080

# Comando por defecto para ejecutar Tomcat
CMD ["catalina.sh", "run"]
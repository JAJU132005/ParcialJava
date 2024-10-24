FROM tomcat:9-jdk11

WORKDIR /usr/local/tomcat/webapps
COPY ./index.jsp /usr/local/tomcat/webapps/parcial2doCorte/
COPY ./WEB-INF/lib/javax.servlet.jsp.jstl-1.2.1.jar /usr/local/tomcat/lib/
COPY ./WEB-INF/lib/mysql-connector-java-5.1.12-bin.jar /usr/local/tomcat/lib/

# Instala Java 19
RUN apt-get update && \
    apt-get install -y openjdk-19-jdk && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Configura la variable de entorno para Java
ENV JAVA_HOME /usr/lib/jvm/java-19-openjdk-amd64

# Expone el puerto 8080
EXPOSE 8080

# Comando por defecto para ejecutar Tomcat
CMD ["catalina.sh", "run"]
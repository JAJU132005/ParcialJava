FROM tomcat:8.5.96

# Instala JDK 19
RUN apt-get update && \
    apt-get install -y openjdk-19-jdk && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Establece la variable de entorno JAVA_HOME
ENV JAVA_HOME /usr/lib/jvm/java-19-openjdk-amd64

WORKDIR /usr/local/tomcat/webapps
COPY ./WebContent /usr/local/tomcat/webapps/parcial2doCorte/
COPY ./WebContent/WEB-INF/lib/javax.servlet.jsp.jstl-1.2.1.jar /usr/local/tomcat/lib/
COPY ./WebContent/WEB-INF/lib/mysql-connector-java-5.1.12-bin.jar /usr/local/tomcat/lib/
COPY ./WebContent/WEB-INF/lib/postgresql-42.2.19.jar /usr/local/tomcat/lib/

# Expone el puerto 8080
EXPOSE 8080

# Comando por defecto para ejecutar Tomcat
CMD ["catalina.sh", "run"]
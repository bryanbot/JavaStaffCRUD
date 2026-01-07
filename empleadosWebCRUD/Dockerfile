FROM tomcat:10.1-jdk17

# Eliminar aplicaciones por defecto de Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copiar el archivo WAR (generado por Maven) como ROOT.war
# Esto hace que la app sea accesible en http://localhost:8080/ directamente
COPY target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
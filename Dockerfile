# Fase 1: Costruzione con OpenJDK e Maven
FROM openjdk:17-jdk-slim AS build

# Installa Maven e altre dipendenze necessarie
RUN apt-get update && apt-get install -y maven

# Imposta la directory di lavoro
WORKDIR /app

# Copia il codice sorgente nell'immagine Docker
COPY . /app

# Esegui la build con Maven
RUN mvn clean package

# Fase 2: Configurazione MySQL (puoi anche usare un'immagine separata MySQL in un ambiente Docker Compose)
FROM mysql:8.0 AS mysql

# Imposta le variabili d'ambiente per MySQL
ENV MYSQL_ROOT_PASSWORD=root_password
ENV MYSQL_DATABASE=webmarket
ENV MYSQL_USER=webmarket_user
ENV MYSQL_PASSWORD=webmarket_pass

# Espone la porta di MySQL
EXPOSE 3306

# Fase 3: Configurazione di Tomcat
FROM tomcat:9.0-jdk17-openjdk-slim

# Copia il WAR costruito nel container Tomcat
COPY --from=build /app/target/webmarket-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/webmarket.war

# Avvia Tomcat
CMD ["catalina.sh", "run"]

# Espone la porta di Tomcat
EXPOSE 8080

# Usa un'immagine base con OpenJDK 17
FROM openjdk:17-jdk-slim AS build

# Installa Maven e altre dipendenze necessarie
RUN apt-get update && apt-get install -y maven

# Imposta la directory di lavoro
WORKDIR /app

# Copia il codice sorgente nell'immagine Docker
COPY . /app

# Esegui la build con Maven
RUN mvn clean package

# Usa Tomcat come immagine base per eseguire l'app
FROM tomcat:9.0-jdk17-openjdk-slim

# Installa MySQL
RUN apt-get update && apt-get install -y mysql-server

# Imposta le variabili d'ambiente per MySQL
ENV MYSQL_ROOT_PASSWORD=root_password
ENV MYSQL_DATABASE=webmarket
ENV MYSQL_USER=webmarket_user
ENV MYSQL_PASSWORD=webmarket_pass

# Copia il WAR costruito nel container Tomcat
COPY --from=build /app/target/webmarket-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/webmarket.war


# Copia il file di configurazione per MySQL (opzionale, solo se desideri un file di configurazione personalizzato)
# COPY config/my.cnf /etc/mysql/my.cnf

# Avvia MySQL e Tomcat
CMD service mysql start && catalina.sh run

# Espone la porta su cui Tomcat è in esecuzione
EXPOSE 8080

# Espone la porta di MySQL
EXPOSE 3306

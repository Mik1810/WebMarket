FROM maven:3.8.4-openjdk-17 AS build

WORKDIR /app
COPY . /app

RUN mvn clean package -DskipTests

FROM tomcat:9-jdk17-openjdk

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=build /app/target/webmarket-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/webmarket.war

RUN mkdir -p /usr/local/tomcat/conf/Catalina/localhost

EXPOSE 8080

CMD ["catalina.sh", "run"]

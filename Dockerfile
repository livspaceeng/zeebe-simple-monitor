FROM maven:3.6.3-jdk-11 AS BUILD_IMAGE
COPY src usr/local/src
COPY pom.xml usr/local
RUN mvn -f usr/local/pom.xml clean package

FROM openjdk:11-jre
EXPOSE 8082
ARG JAR=usr/local/target/zeebe-simple-monitor-*-SNAPSHOT.jar
COPY --from=BUILD_IMAGE ${JAR} /usr/local/zeebe-simple-monitor.jar
ENTRYPOINT ["java", "-jar", "/usr/local/zeebe-simple-monitor.jar"]

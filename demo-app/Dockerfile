FROM eclipse-temurin:latest
RUN apt update -y && apt --only-upgrade install -y libssl3
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar","/app.jar"]


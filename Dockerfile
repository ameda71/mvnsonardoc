FROM openjdk:17
WORKDIR /app
COPY target/*.jar app.jar
EXPOSE 8081
CMD ["java", "-jar", "app.jar"]

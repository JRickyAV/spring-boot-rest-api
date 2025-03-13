# Use a lightweight JDK base image
FROM eclipse-temurin:17-jdk-alpine

# Set application directory
WORKDIR /app

# Copy the JAR file into the container
COPY target/*.jar app.jar

# Expose the application port (Cloud Run uses 8080 by default)
EXPOSE 8080

# Set environment variable for Cloud Run
ENV PORT=8080

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "/app.jar"]

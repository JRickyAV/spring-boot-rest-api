# Step 1: Use an official Maven image to build the JAR
FROM maven:3.9.6-eclipse-temurin-17 AS builder
WORKDIR /app

# Copy the project files into the container
COPY . .

# Build the application (creates target/*.jar)
RUN mvn clean package -DskipTests

# Step 2: Use a lightweight JDK image to run the app
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app

# Copy the JAR file from the builder stage
COPY --from=builder /app/target/*.jar app.jar

# Expose port 8080 for Cloud Run
EXPOSE 8080

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "/app.jar"]
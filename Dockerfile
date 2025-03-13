# Step 1: Use a Maven image to build the JAR
FROM maven:3.9.6-eclipse-temurin-17 AS builder
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Step 2: Use a lightweight JDK image to run the app
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar

# Expose port 8080 for Cloud Run
EXPOSE 8080

# Run the application (Cloud Run sets PORT automatically)
ENTRYPOINT ["java", "-jar", "/app.jar", "--server.port=${PORT}"]

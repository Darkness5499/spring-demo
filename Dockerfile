# --------- Build stage ---------
FROM eclipse-temurin:21-jdk AS build
WORKDIR /app

# Copy Maven wrapper & pom.xml
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

# Download dependencies (cache layer)
RUN ./mvnw dependency:go-offline -B

# Copy source code
COPY src ./src

# Build jar
RUN ./mvnw package -DskipTests

# --------- Run stage ---------
FROM eclipse-temurin:21-jre
WORKDIR /app

# Copy đúng jar đã build
COPY --from=build /app/target/spring-demo-0.0.1-SNAPSHOT.jar app.jar

# Expose port Spring Boot
EXPOSE 8080

# Run Spring Boot app
ENTRYPOINT ["java", "-jar", "app.jar"]

# Bước 1: Dùng Image Maven để build file JAR
FROM maven:3.8.runtime-openjdk-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Bước 2: Dùng Image JRE tinh gọn để chạy file JAR (giúp giảm dung lượng)
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8081
ENTRYPOINT ["java", "-jar", "app.jar"]
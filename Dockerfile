# ---------------------
# Stage 1: Build
# ---------------------
FROM gradle:8.4-jdk17 as builder
WORKDIR /app
COPY . .
RUN ./gradlew clean bootJar --no-daemon --refresh-dependencies

# ---------------------
# Stage 2: Runtime
# ---------------------
FROM eclipse-temurin:17-jdk-jammy
WORKDIR /app
COPY --from=builder /app/build/libs/*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]

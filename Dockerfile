FROM openjdk:11-jre-slim
ARG DOCKERIZE_VERSION=v0.7.0
ENV SPRING_PROFILES_ACTIVE docker,mysql
ADD https://github.com/jwilder/dockerize/releases/download/${DOCKERIZE_VERSION}/dockerize-alpine-linux-amd64-${DOCKERIZE_VERSION}.tar.gz /dockerize.tar.gz
RUN tar -xzf /dockerize.tar.gz && \
    chmod +x /dockerize
COPY --from=build /app/target/*.jar /app.jar

# Expose and set entrypoints for multiple ports
EXPOSE 9090 8080 8888 8081 8761 7979 8083 8082
ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/app.jar"]
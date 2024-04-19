FROM openjdk:8-jdk-alpine
VOLUME /tmp
EXPOSE 8000
RUN mkdir -p /var/lib/docker/tmp/buildkit-mount3152033135/target
ADD target/*.jar app.jar
ENV JAVA_OPTS=""
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app.jar" ]

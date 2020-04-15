#
# Primera etapa - container para build
# Uso la imagen Gradle 5.3 (basada en openjdk:8-jdk)
#
FROM gradle:5.3-jdk8 as builder

# Defino el workdir
WORKDIR /home/gradle

# Agrego el código del proyecto al Workdir
ADD . /home/gradle

# Compilo la aplicación (como un fat jar)
RUN gradle assemble --no-build-cache --no-daemon

#
# Segunda etapa - container de aplicación
#
FROM openjdk:8-jre-alpine

# Creo un directorio y copio el fat jar desde el builder
RUN mkdir /app
COPY --from=builder /home/gradle/build/libs/*all.jar \
     /app/application.jar

# El puerto en el que escuchará la app es el 8080
EXPOSE 8080

# Ejecuto el container y paso las opciones de ejecución a la JVM
CMD ["java", "-jar", "-XX:+UseContainerSupport", \
     "-Djava.security.egd=file:/dev/./urandom", \
     "/app/application.jar"]
# Equivalente a :
# java -jar -XX:+UseContainerSupport -Djava.security.egd=file:/dev/./urandom /app/application.jar
# Uso la imagen OpejJDK versión 8
FROM openjdk:8-jdk

# Defino el workdir
WORKDIR /app

# Agrego el código del proyecto al Workdir
ADD . /app

# Compilo la aplicación (como un fat jar)
RUN ./gradlew assemble --no-build-cache --no-daemon

# Copio el fat jar a la raíz del Workdir
RUN cp build/libs/app-*all.jar application.jar

# El puerto en el que escuchará la app es el 8080
EXPOSE 8080

# Ejecuto el container y paso las opciones de ejecución a la JVM
CMD ["java", "-jar", "-XX:+UseContainerSupport", "-Djava.security.egd=file:/dev/./urandom", "application.jar"]
# Equivalente a :
# java -jar -XX:+UseContainerSupport -Djava.security.egd=file:/dev/./urandom application.jar
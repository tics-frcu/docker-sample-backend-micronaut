# Uso la imagen Gradle 5.3 (basada en openjdk:8-jdk)
FROM gradle:5.3-jdk8

# Defino el workdir
WORKDIR /home/gradle

# Agrego el código del proyecto al Workdir
ADD . /home/gradle

# Compilo la aplicación (como un fat jar)
RUN gradle assemble --no-build-cache --no-daemon

# Copio el fat jar a la raíz del Workdir
RUN cp build/libs/*all.jar application.jar

# El puerto en el que escuchará la app es el 8080
EXPOSE 8080

# Ejecuto el container y paso las opciones de ejecución a la JVM
CMD ["java", "-jar", "-XX:+UseContainerSupport", "-Djava.security.egd=file:/dev/./urandom", "application.jar"]
# Equivalente a :
# java -jar -XX:+UseContainerSupport -Djava.security.egd=file:/dev/./urandom application.jar
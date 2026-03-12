FROM dorowu/ubuntu-desktop-lxde-vnc

USER root

RUN rm -f /etc/apt/sources.list.d/google-chrome.list

RUN apt-get update && apt-get install -y \
    openjdk-21-jdk \
    maven

ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests

CMD ["bash","-c","java -jar target/sum-product_fx-1.0-SNAPSHOT.jar"]
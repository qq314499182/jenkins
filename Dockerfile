FROM openjdk:8
VOLUME /temp
ENV JVM_OPS="-Xms256m -Xmx256m -XX:MetaspaceSize=512m -XX:MaxMetaspaceSize=512m"
ENV JAVA_POS=""
ADD /target/jenkins.jar jenkins.jar
ENTRYPOINT java -Djava.security.egd=file:/dev/./urandom -jar ${JVM_OPS} jenkins.jar ${JAVA_OPS}
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
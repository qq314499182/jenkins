FROM openjdk:8

VOLUME /temp

ENV JVM_OPS="-Xms256m -Xmx256m -XX:PermSize=512M"

ENV JAVA_POS=""

ADD /target/jenkins.jar jenkins.jar

ENTRYPOINT java -Djava.security.egd=file:/dev/./urandom -jar ${JVM_OPS} jenkins.jar ${JAVA_OPS}

ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#编译命令1
#docker build -t jenkins:1.0.0 .

#删除虚悬镜像none
#docker rmi $(docker images -q -f dangling=true)

#启动命令
#docker run -d --network host --restart=always --name jenkins jenkins:1.0.0

#查看日志
#docker logs -f -t --tail=100 jenkins
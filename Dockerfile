FROM ubuntu:latest
RUN  sed -i 's/^#\s*\(deb.*universe\)$/\1/g' /etc/apt/sources.list 
ENV MAVEN_VERSION=3.3.9 
ENV MAVEN_HOME=/usr/share/maven 
ENV LANGUAGE=en_US:en 
#ENV DOCKER_HOST tcp://0.0.0.0:2375
ENV LANG=C.UTF-8 TZ=Asia/Shanghai 
ENV JRE_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre/ 
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
ENV JENKINS_HOME /home/jenkins
ENV JENKINS_REMOTNG_VERSION 2.53.1
RUN apt update && apt-get install -y software-properties-common && add-apt-repository ppa:openjdk-r/ppa && apt-get update && apt-get install openjdk-8-jdk -y &&  apt-get install -y lrzsz git unzip vim curl wget maven npm nodejs python3 python3-pip dnsutils && rm -rf /var/lib/apt/lists/* 
######install docker ###

RUN curl -sSL https://get.docker.com/ | sh
###### install jenkins Remoting agent
RUN curl --create-dirs -sSLo /usr/share/jenkins/slave.jar http://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/$JENKINS_REMOTNG_VERSION/remoting-$JENKINS_REMOTNG_VERSION.jar \
    && chmod 755 /usr/share/jenkins \
    && chmod 644 /usr/share/jenkins/slave.jar
COPY jenkins-slave /usr/local/bin/jenkins-slave
#COPY docker /bin/docker
ENTRYPOINT ["/bin/sh" "-c" "/usr/local/bin/jenkins-slave"]
#RUN curl -L https://github.com/docker/compose/releases/download/1.16.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose &&  chmod +x /usr/local/bin/docker-compose                                                                             

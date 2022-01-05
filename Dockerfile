FROM centos:latest

MAINTAINER nguyen thanh dat datptit@gmail.com


WORKDIR /opt

RUN yum -y install java-1.8.0-openjdk
RUN yum -y install wget
RUN wget https://github.com/wildfly/wildfly/releases/download/26.0.0.Final/wildfly-26.0.0.Final.tar.gz 
RUN tar xvfz wildfly-26.0.0.Final.tar.gz
RUN ln -s wildfly-26.0.0.Final /opt/wildfly
RUN groupadd -r wildfly -g 12345 && useradd -u 54321 -r -g wildfly -d /opt/wildfly -s /sbin/nologin -c "WildFly user" wildfly
RUN wildfly/bin/add-user.sh wildfly 1 --silent
RUN chown -R wildfly:wildfly /opt/wildfly/*

EXPOSE 8080 9990

USER wildfly

CMD ["/opt/wildfly/bin/standalone.sh", "-b", "0.0.0.0","-bmanagement", "0.0.0.0"]

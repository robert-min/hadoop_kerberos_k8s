FROM centos:7

USER root

RUN yum clean all
RUN rpm --rebuilddb
RUN yum install -y initscripts curl which tar sudo openssh-server openssh-clients nc perl snappy snappy-devel wget
RUN yum update -y libselinux


# java
ADD config/jdk-8u333-linux-x64.tar.gz /usr/lib/jdk1.8.0_333
RUN mv /usr/lib/jdk1.8.0_333 /usr/lib/jvm
ENV JAVA_HOME=/usr/lib/jvm/jdk1.8.0_333
ENV JRE_HOME=/usr/lib/jvm/jdk1.8.0_333/jre
ENV PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin
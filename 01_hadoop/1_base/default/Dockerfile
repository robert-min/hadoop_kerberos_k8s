FROM robertmin/centos-java


# hadoop install
RUN curl -O --insecure https://dist.apache.org/repos/dist/release/hadoop/common/KEYS
RUN gpg --import KEYS

ARG HADOOP_VERSION=2.7.3

RUN wget --no-check-certificate https://archive.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz \
    && tar xvfz hadoop-$HADOOP_VERSION.tar.gz \
    && mv hadoop-$HADOOP_VERSION /opt/hadoop-$HADOOP_VERSION \
    && rm hadoop-$HADOOP_VERSION.tar.gz

RUN mkdir /opt/hadoop-$HADOOP_VERSION/logs
RUN cd /opt/hadoop-$HADOOP_VERSION && ln -s /opt/hadoop
RUN ln -s /opt/hadoop-$HADOOP_VERSION/etc/hadoop /etc/hadoop
RUN mkdir /hadoop && mkdir /hadoop/dfs %% mkdir /hadoop/yarn
RUN mkdir /hadoop-data

ENV HADOOP_HOME=/opt/hadoop-$HADOOP_VERSION
ENV HADOOP_CONF_DIR=/etc/hadoop
ENV MULTIHOMED_NETWORK=1
ENV PATH $HADOOP_HOME/bin/:$PATH

# default setting
ADD ./config/core-site.xml ${HADOOP_CONF_DIR}/core-site.xml
ADD ./config/hdfs-site.xml ${HADOOP_CONF_DIR}/hdfs-site.xml
ADD ./config/yarn-site.xml ${HADOOP_CONF_DIR}/yarn-site.xml
ADD ./config/mapred-site.xml ${HADOOP_CONF_DIR}/mapred-site.xml

# HDFS ports
EXPOSE 8485 9000 50070 
# Mapred ports

# YARN ports
EXPOSE 8089 
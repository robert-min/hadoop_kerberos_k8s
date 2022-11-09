#!/bin/bash
$HADOOP_HOME/sbin/hadoop-daemon.sh start journalnode

$HADOOP_HOME/bin/hdfs --config $HADOOP_CONF_DIR namenode -format

$HADOOP_HOME/bin/hdfs --config $HADOOP_CONF_DIR namenode
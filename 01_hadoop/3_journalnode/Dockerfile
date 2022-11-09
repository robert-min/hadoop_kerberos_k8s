FROM robertmin/hadoop_base:2.7.3


RUN mkdir -p /hadoop/dfs/journal
VOLUME /hadoop/dfs/journal

ADD start.sh /start.sh
RUN chmod a+x /start.sh

CMD ["/start.sh"]
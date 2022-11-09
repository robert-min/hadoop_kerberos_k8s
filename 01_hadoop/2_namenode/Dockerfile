FROM robertmin/hadoop_base:2.7.3

HEALTHCHECK CMD curl -f http://localhost:9870/ || exit 1

RUN mkdir -p /hadoop/dfs/name && mkdir -p /hadoop/dfs/journal
VOLUME /hadoop/dfs/name 

VOLUME /hadoop/dfs/journal

ADD start.sh /start.sh
RUN chmod a+x /start.sh

CMD ["/start.sh"]
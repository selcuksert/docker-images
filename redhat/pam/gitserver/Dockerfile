FROM gitea/gitea

LABEL Author="Selcuk SERT" mail="selcuk.sert@gmail.com"

ADD ./config/app.ini /data/gitea/conf/app.ini
ADD ./scripts/start.sh /usr/bin/start.sh

# Run application
ENTRYPOINT ["start.sh"]
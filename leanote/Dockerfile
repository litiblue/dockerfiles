FROM ubuntu:17.10

RUN apt-get update && apt-get upgrade
RUN apt-get install -y curl

RUN curl -L https://sourceforge.net/projects/leanote-bin/files/2.6/leanote-linux-amd64-v2.6.bin.tar.gz/download >> \
    /usr/local/leanote-linux-amd64.bin.tar.gz

RUN tar -xzvf /usr/local/leanote-linux-amd64.bin.tar.gz -C /usr/local
RUN chmod +x /usr/local/leanote/bin/run.sh

RUN hash=$(< /dev/urandom tr -dc A-Za-z0-9 | head -c${1:-64};echo;); \
    sed -i "s/app.secret=.*$/app.secret=$hash #/" /usr/local/leanote/conf/app.conf; \
    sed -i "s/db.host=.*$/db.host=db/" /usr/local/leanote/conf/app.conf; \
    sed -i "s/site.url=.*$/site.url=\${SITE_URL} /" /usr/local/leanote/conf/app.conf; \
    sed -i "s/http.addr=.*$/http.addr=0.0.0.0/" /usr/local/leanote/conf/app.conf;

# install mongodb
RUN apt-get install dirmngr
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 \
    --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5
RUN echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.6.list
RUN apt-get update && apt-get install -y mongodb-org

COPY init.sh /tmp/
EXPOSE 9000
ENTRYPOINT ["sh", "/tmp/init.sh"]

FROM asciidoctor/docker-asciidoctor
LABEL MAINTAINER Satoru YAMASAKI <gookun@gmail.com>

ENV COMPASS_VERSION 0.12.7
ENV ZURB_FOUNDATION_VERSION 4.3.2
ENV MERMAID_VERSION 7.0.9
WORKDIR /root

RUN gem install asciidoctor-pdf-cjk-kai_gen_gothic -N && \
    gem install --version ${COMPASS_VERSION} compass -N && \
    gem install --version ${ZURB_FOUNDATION_VERSION} zurb-foundation -N && \
    asciidoctor-pdf-cjk-kai_gen_gothic-install && \
    ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    apk add --no-cache nodejs nodejs-npm ca-certificates openssl && \
    rm -rf /tmp/* /var/tmp/* && \
    wget -O VLGothic.zip "http://osdn.jp/frs/redir.php?m=jaist&f=%2Fvlgothic%2F62375%2FVLGothic-20141206.zip" && \
    unzip VLGothic.zip && \
    mkdir -p /root/.fonts && \
    cp VLGothic/VL-Gothic-Regular.ttf /root/.fonts && \
    rm -rf /root/VLGothic* && \
    wget https://github.com/asciidoctor/asciidoctor-stylesheet-factory/archive/master.zip && \
    unzip master.zip && \
    cd asciidoctor-stylesheet-factory-master && \
    compass compile && \
    cp -pr stylesheets / && \
    cd .. && \
    rm -rf master.zip asciidoctor-stylesheet-factory-master
   
WORKDIR /documents

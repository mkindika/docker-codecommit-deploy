FROM alpine:3.4

RUN apk add --no-cache git python py-pip \
 && pip install --no-cache-dir awscli docker-compose \
 && git config --global credential.helper '!aws codecommit credential-helper $@' \
 && git config --global credential.UseHttpPath true \
 && git --version \
 && aws --version \
 && docker-compose -v

WORKDIR /var/compose

ENV INTERVAL=-1 \
    REPO=required

ADD run.sh /run.sh

CMD ["/run.sh"]

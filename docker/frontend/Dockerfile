FROM python:2.7-alpine
MAINTAINER ctelliott@gmail.com

RUN apk add --update \
    vim \
  && rm -rf /var/cache/apk/*

WORKDIR /opt/app

ADD src/requirements.txt .
RUN pip install -r ./requirements.txt

ADD src .
RUN chmod +x *py

ENTRYPOINT ["./server.py"]

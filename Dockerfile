# docker build -t brian/sz_sqs_consumer .
# docker run --user $UID -it -v $PWD:/data -e AWS_DEFAULT_REGION -e AWS_SECRET_ACCESS_KEY -e AWS_ACCESS_KEY_ID -e AWS_SESSION_TOKEN -e SENZING_ENGINE_CONFIGURATION_JSON brian/sz_sqs_consumer -q <queue url>

ARG BASE_IMAGE=senzing/senzingsdk-runtime:latest
FROM ${BASE_IMAGE}

LABEL Name="brian/sz_file_loader" \
      Maintainer="brianmacy@gmail.com" \
      Version="DEV"

USER root

RUN apt-get update \
 && apt-get -y install senzingsdk-poc\
 && apt-get -y autoremove \
 && apt-get -y clean

ENV PYTHONPATH=/opt/senzing/er/sdk/python

USER 1001

WORKDIR /tmp
ENTRYPOINT ["/opt/senzing/er/bin/sz_file_loader"]


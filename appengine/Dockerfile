ARG BASE_IMAGE=mlflow:standard

FROM $BASE_IMAGE

WORKDIR /mlflow/

RUN mkdir -p /opt && \
    curl https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GCLOUD_VERSION}-linux-x86_64.tar.gz \
    --output /tmp/google-cloud-sdk-${GCLOUD_VERSION}-linux-x86_64.tar.gz && \
    tar -zxf /tmp/google-cloud-sdk-${GCLOUD_VERSION}-linux-x86_64.tar.gz -C /opt/
ENV PATH=$PATH:/opt/google-cloud-sdk/bin

COPY run_server.sh .
RUN chmod +x run_server.sh

CMD /mlflow/run_server.sh
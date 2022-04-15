FROM google/cloud-sdk:381.0.0-slim

WORKDIR /mlflow/

RUN mkdir -p /mlflow/ \
  && apt-get update --allow-releaseinfo-change\
  && apt-get -y install --no-install-recommends apt-transport-https \
  ca-certificates gnupg default-libmysqlclient-dev libpq-dev build-essential curl

ARG MLFLOW_VERSION="1.25.1"

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

RUN echo "export LC_ALL=$LC_ALL" >> /etc/profile.d/locale.sh
RUN echo "export LANG=$LANG" >> /etc/profile.d/locale.sh

RUN pip install --no-cache-dir --ignore-installed google-cloud-storage boto3 && \
    pip install --no-cache-dir psycopg2-binary PyMySQL mlflow==$MLFLOW_VERSION pyarrow

COPY run_server.sh .
RUN chmod +x run_server.sh

CMD /mlflow/run_server.sh
FROM python:3.8-slim

ARG MLFLOW_VERSION="1.*"

RUN mkdir /mlflow

WORKDIR /mlflow

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

RUN echo "export LC_ALL=$LC_ALL" >> /etc/profile.d/locale.sh
RUN echo "export LANG=$LANG" >> /etc/profile.d/locale.sh

RUN pip install --no-cache-dir --ignore-installed google-cloud-storage boto3 && \
    pip install --no-cache-dir psycopg2-binary mlflow==$MLFLOW_VERSION pyarrow

EXPOSE 8080

COPY start.sh start.sh

CMD ["./start.sh"]

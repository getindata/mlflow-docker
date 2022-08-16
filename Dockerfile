FROM python:3.10-slim-bullseye as base

ARG MLFLOW_VERSION="1.*"

RUN mkdir /mlflow

WORKDIR /mlflow

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

RUN echo "export LC_ALL=$LC_ALL" >> /etc/profile.d/locale.sh
RUN echo "export LANG=$LANG" >> /etc/profile.d/locale.sh

RUN echo "deb http://ftp.debian.org/debian experimental main contrib non-free" >> /etc/apt/sources.list && \
    apt-get update && apt-get upgrade -y && apt-get install curl -y && \
    apt upgrade -t experimental libc6 -y && \
    curl -O "http://http.us.debian.org/debian/pool/main/p/pcre2/libpcre2-8-0_10.40-1_amd64.deb" && dpkg -i libpcre2-8-0_10.40-1_amd64.deb && \
    rm -rf /var/lib/apt/lists/*

FROM base as azure
RUN apt-get update && apt-get install gnupg -y && \
    curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
    apt-get update && \
    ACCEPT_EULA=Y apt-get install -y msodbcsql18 && \
    ACCEPT_EULA=Y apt-get install -y mssql-tools18 && \
    rm -rf /var/lib/apt/lists/*

ENV PATH="${PATH}:/opt/mssql-tools18/bin"

RUN pip install --no-cache-dir --ignore-installed azure-identity azure-storage-blob && \
    pip install --no-cache-dir "pyodbc~=4.0.34" "mlflow==$MLFLOW_VERSION" pyarrow

EXPOSE 8080

COPY start.sh start.sh

CMD ["./start.sh"]

FROM base as gcp-aws
RUN pip install --no-cache-dir --ignore-installed google-cloud-storage boto3 && \
    pip install --no-cache-dir psycopg2-binary PyMySQL mlflow==$MLFLOW_VERSION pyarrow

EXPOSE 8080

COPY start.sh start.sh

CMD ["./start.sh"]

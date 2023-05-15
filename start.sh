#!/bin/bash
exec mlflow server \
        --host 0.0.0.0 \
        --port 8080 \
        --backend-store-uri $BACKEND_STORE_URI \
        --default-artifact-root $DEFAULT_ARTIFACT_ROOT

DB_PASSWORD=$(gcloud secrets versions access --project=${GCP_PROJECT} --secret=${DB_PASSWORD_SECRET_NAME} latest)
BACKEND_URI=mysql+pymysql://${DB_USERNAME}:${DB_PASSWORD}@${DB_ADDRESS}:3306/${DB_NAME}

mlflow db upgrade ${BACKEND_URI}
echo "DB upgrade done"

mlflow server \
  --backend-store-uri ${BACKEND_URI} \
  --default-artifact-root ${GCS_BACKEND} \
  --host 0.0.0.0 \
  --port ${PORT}
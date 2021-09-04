# setup a service account because our Cloud Run endpoint is not public accessible
gcloud iam service-accounts create vertex-ai-pipeline-schedule


gcloud projects add-iam-policy-binding sascha-playground-doit \
    --member "serviceAccount:vertex-ai-pipeline-schedule@sascha-playground-doit.iam.gserviceaccount.com" \
    --role "roles/run.invoker"

 gcloud scheduler jobs create http \
    JOB_NAME \
    --schedule SCHEDULE \
    --uri CLOUD_RUN_URL \
    --oidc-service-account-email vertex-ai-pipeline-schedule@sascha-playground-doit.iam.gserviceaccount.com
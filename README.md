## Vertex AI Pipeline Scheduler (interim solution until there is a proper implementation on Google side)

**TLDR** The Vertex AI Pipeline scheduler stores the pipeline specification as raw string in the body of the Cloud Scheduler. This way we cant implement CI/CD in a proper way. This repository contains a interim solution that takes the pipeline specification from Google Cloud Storage. This way we can implement CI/CD for Vertex AI Pipelines.

Medium article will be published soon

## Installation deploy to Cloud Run

- Enable Cloud Build to deploy to Cloud Run https://cloud.google.com/build/docs/deploying-builds/deploy-cloud-run#required_iam_permissions
- Setup a Cloud Build deployment using the cloudbuild.yaml

Or alternative manually deploy to Cloud Run using deploy.sh

```
docker build -t gcr.io/sascha-playground-doit/vertex/pipeline/schedule .
docker push gcr.io/sascha-playground-doit/vertex/pipeline/schedule

gcloud run deploy vertex-ai-pipeline-schedule \
 --image gcr.io/sascha-playground-doit/vertex/pipeline/schedule \
 --region us-east1 \
 --platform managed \
 --memory 256Mi \
 --no-allow-unauthenticated
```

## Usage

After the deployment to Cloud Run we need to setup the Cloud Scheduler to schedule our pipeline run.

Because our Cloud Run endpoint is not public accessible we need to set up a service account. Granting the rights to invoke Cloud Run by assigning the role `run.invoker`

```
gcloud iam service-accounts create vertex-ai-pipeline-schedule


gcloud projects add-iam-policy-binding sascha-playground-doit \
    --member "serviceAccount:vertex-ai-pipeline-schedule@sascha-playground-doit.iam.gserviceaccount.com" \
    --role "roles/run.invoker"
```

And finally we create our Cloud Scheduler job. https://cloud.google.com/sdk/gcloud/reference/scheduler/jobs/create/http

```
 gcloud scheduler jobs create http \
    vertex-ai-basic-pipeline\
    --schedule "0 */12 * * *" \
    --uri https://vertex-ai-pipeline-schedule-xgdxnb6fdq-ue.a.run.app/ \
    --oidc-service-account-email vertex-ai-pipeline-schedule@sascha-playground-doit.iam.gserviceaccount.com \
    --message-body "{
    \"templatePath\": \"gs://doit-vertex-demo/basic_pipeline.json\",
    \"project\": \"sascha-playground-doit\",
    \"location\": \"us-central1\"
}"
```

##  Vertex AI Pipeline Scheduler (interim solution until there is a proper implementation on Google side)
This is still a DRAFT readme not completed yet. There is a deep dive article soon to be published as well. 

This project contains a Vertex AI Pipeline Scheduler that can work in a CI/CD environment.

**TLDR** The Vertex AI Pipeline scheduler stores the pipeline specification as raw string in the body of the Cloud Scheduler. This way we cant implement CI/CD in a proper way. This repository contains a interim solution that takes the pipeline specification from Google Cloud Storage. This way we can implement CI/CD for Vertex AI Pipelines. 


## Installation deploy to Cloud Run
* Enable Cloud Build to deploy to Cloud Run https://cloud.google.com/build/docs/deploying-builds/deploy-cloud-run#required_iam_permissions
* Setup a Cloud Build deployment using the cloudbuild.yaml

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
* After the deployment to Cloud Run we need to setup the Cloud Scheduler to schedule our pipeline run. 
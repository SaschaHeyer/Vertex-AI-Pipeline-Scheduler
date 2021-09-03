##  Vertex AI Pipeline Scheduler
This is still a DRAFT readme not completed yet. There is a deep dive article soon to be published as well. 

This project contains a Vertex AI Pipeline Scheduler that can work in a CI/CD environment. 


## Installation deploy to Cloud Run
* Enable Cloud Build to deploy to Cloud Run https://cloud.google.com/build/docs/deploying-builds/deploy-cloud-run#required_iam_permissions
* Setup a Cloud Build deployment using the cloudbuild.yaml
* Or alternative use the deploy.sh if you don't want to use Cloud Build

## Usage
* After the deployment to Cloud Run we need to setup the Cloud Scheduler to schedule our pipeline run. 
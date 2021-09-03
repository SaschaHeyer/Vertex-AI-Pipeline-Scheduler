docker build -t gcr.io/sascha-playground-doit/vertex/pipeline/schedule .
docker push gcr.io/sascha-playground-doit/vertex/pipeline/schedule

gcloud run deploy vertex-ai-pipeline-schedule \
 --image gcr.io/sascha-playground-doit/vertex/pipeline/schedule \
 --region us-east1 \
 --platform managed \
 --memory 256Mi \
 #--no-allow-unauthenticated


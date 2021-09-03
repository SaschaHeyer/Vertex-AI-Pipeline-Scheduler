import uvicorn

from google.cloud import storage
from google.cloud import aiplatform
from google.cloud.aiplatform import pipeline_jobs
from fastapi import Request, FastAPI

app = FastAPI()
storageClient = storage.Client()


@app.post('/')
async def predict(request: Request):
    body = await request.json()

    # validation is manged via PipelineJob
    templatePath = body['templatePath']
    project = body['project']
    location = body['location']

    # default value as parameters are optional
    parameters = body.get('parameters', {})

    aiplatform.init(project=project, location=location)

    # TODO handle pipeline parameters
    pipeline = pipeline_jobs.PipelineJob(
        display_name="not used at the moment but needs to be set",
        template_path=templatePath,
        parameter_values=parameters,
    )

    # Unfortuantly run does not return anything instead it logs in the background
    # TODO even with sync false is stays in the thread and logs the output
    # https://github.com/googleapis/python-aiplatform/issues/688
    pipeline.run(sync=False)
    
    # Return true for now until the SDK returns a proper value for the run
    # TODO open a GitHub issue in the Vertex AI SDK repository
    return True 


if __name__ == "__main__":
    uvicorn.run(app, debug=True)

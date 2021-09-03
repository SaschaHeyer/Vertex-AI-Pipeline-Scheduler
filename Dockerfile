FROM tiangolo/uvicorn-gunicorn:python3.8

COPY main.py ./main.py
COPY requirements.txt ./requirements.txt

RUN pip install -r requirements.txt
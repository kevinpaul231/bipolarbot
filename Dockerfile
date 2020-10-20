FROM python:3.7.9-buster
WORKDIR /bipolarbot
ADD . /bipolarbot
RUN pip install -r requirements.txt
CMD ["python","server.py"]

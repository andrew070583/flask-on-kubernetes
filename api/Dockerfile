FROM ubuntu:latest
RUN apt-get update -y
RUN apt-get install -y python3 python3-pip python3-dev build-essential
COPY requirements.txt /app/requirements.txt
WORKDIR /app
RUN pip3 install -r requirements.txt
COPY app.py /app/app.py
COPY index.html /app/index.html

ENTRYPOINT [ "python3" ]
CMD [ "app.py" ]

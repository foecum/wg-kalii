from python:3.6

MAINTAINER collins.abitekaniza@andela.com

WORKDIR /app

COPY . /app

RUN apt-get -y update && \
      apt-get install -y nodejs npm && \
      npm install bower

RUN pip install -r requirements.txt

RUN invoke create-settings \
         --settings-path ~/.config/wger/settings.py

ENTRYPOINT invoke bootstrap-wger \
         --settings-path ~/.config/wger/settings.py \
         --no-start-server && \
         invoke start-wger --address 0.0.0.0 --port 8000


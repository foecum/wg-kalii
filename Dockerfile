from python:3.6

MAINTAINER collins.abitekaniza@andela.com

WORKDIR /app

COPY . /app

RUN apt-get -y update && \
      apt-get install -y nodejs npm && \
      npm install bower

RUN pip install -r requirements.txt

RUN invoke create-settings \
         --settings-path ~/.config/wger/settings.py \
         --database-path ~/.config/wger/database.sqlite && \
 invoke bootstrap-wger \
         --settings-path ~/.config/wger/settings.py \
         --no-start-server

RUN python3 manage.py migrate

ENTRYPOINT ["python", "manage.py", "runserver", "0.0.0.0:8000"]

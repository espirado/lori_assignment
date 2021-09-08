## pull official base image
#FROM python:3.6
FROM python:3.7-alpine3.8

# set work directory
WORKDIR /usr/src/app


# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
 
# install psycopg2 dependencies
RUN apk update
RUN apk add jpeg-dev zlib-dev freetype-dev lcms2-dev openjpeg-dev tiff-dev tk-dev tcl-dev
RUN apk add postgresql-dev gcc python3-dev musl-dev 


   


# install dependencies
RUN pip install virtualenv 
RUN virtualenv -p python3 env
RUN source env/bin/activate
RUN apk add build-base
RUN pip install --upgrade cython 
RUN pip install  psycopg2-binary
RUN pip install versioneer
COPY ./requirements.txt .
RUN pip install -r requirements.txt


# copy entrypoint.sh
COPY ./entrypoint.sh .
RUN sed -i 's/\r$//g' /usr/src/app/entrypoint.sh
RUN chmod +x /usr/src/app/entrypoint.sh

# copy project
COPY . .


# run entrypoint.sh
ENTRYPOINT ["/usr/src/app/entrypoint.sh"]
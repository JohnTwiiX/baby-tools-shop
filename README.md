# E-Commerce Project For Baby Tools

### TECHNOLOGIES

- Python 3.9
- Django 4.0.2
- Venv

### Docker configuration

1. if Docker is not yet installed
```bash
sudo apt update
sudo apt upgrade
sudo install docker.io
```

2. create a docker image
```bash
# create a Dockerfile without ending
# use touch, nano, or vim
nano Dockerfile
```
```bash
FROM python:3.9-slim

WORKDIR /app

# Copy the directory
COPY . $WORKDIR

# Install requirements
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

WORKDIR /app/babyshop_app

# Run migrations and collect static files
RUN python manage.py makemigrations && \
    python manage.py migrate && \
    python manage.py collectstatic --noinput

# Create superuser using environment variables
ARG DJANGO_SUPERUSER_USERNAME
ARG DJANGO_SUPERUSER_EMAIL
ARG DJANGO_SUPERUSER_PASSWORD
RUN python manage.py createsuperuser --noinput --username $DJANGO_SUPERUSER_USERNAME --email $DJANGO_SUPERUSER_EMAIL --password $DJANGO_SUPERUSER_PASSWORD

# Start Django
ENTRYPOINT ["gunicorn", "--bind", "0.0.0.0:8000", "babyshop.wsgi:application"]
```
```bash
# create image
# docker search Dockerfile alone in the current project
docker build --build-arg DJANGO_SUPERUSER_USERNAME=<your-username> --build-arg DJANGO_SUPERUSER_EMAIL=<your-username> --build-arg DJANGO_SUPERUSER_PASSWORD=<your-password> -t babyshop:<your-tag> .

# create
docker build -t <image-name> <wherever>
# -t Name and optionally a tag in the <image-name>:<image-tag> format

# shows all
docker images

# delete one or more
docker image rm -f <image-name>
# -f Force removal of the image
```

3. create volume for saving data
```bash
# create volume
docker volume create babyshop_db

# create
docker volume create <volume-name>

# shows all
docker volume ls

# delete one or more
docker volume rm <volume-name>
```

4. start a docker container
```bash
# run the container with an image and a volume
docker run -d --name babyshop \
    -p 8025:8000 \
    -v babyshop_db:/app/babyshop_app/db.sqlite3 \
    -v babyshop_media:/app/babyshop_app/media \
    -v babyshop_static:/app/babyshop_app/static \
    --restart on-failure \
    babyshop:<your-tag>

# -d Run container in background and print container ID

# --name <name-of-container>

# -p <server-port>:<container-port> server-port redirect to docker-port

# -v <volume-name>:/path/to/storage 

# --restart to restart the container if it fails

# babyshop is the created image
```

5. now you can see it in the browser
```bash
<server-ip>:<port>
```

6. create a superuser in the container
```bash
# find the container id
docker ps -a

# connect to your running container
docker exec -it <container-id> bash

# docker exec    - that allows you to run a new command in a running container
# -it            - allows you to interact with the command-line interface as if you were connected directly to it
# <container-id> - container you want to interact with
# bash           - want to run inside the container
```

### Hints

This section will cover some hot tips when trying to interact with this repository:

- Settings & Configuration for Django can be found in `babyshop_app/babyshop/settings.py`
- Routing: Routing information, such as available routes can be found from any `urls.py` file in `babyshop_app` and corresponding subdirectories

### Photos

##### Home Page with login

<img alt="" src="https://github.com/MET-DEV/Django-E-Commerce/blob/master/project_images/capture_20220323080815407.jpg"></img>
##### Home Page with filter
<img alt="" src="https://github.com/MET-DEV/Django-E-Commerce/blob/master/project_images/capture_20220323080840305.jpg"></img>
##### Product Detail Page
<img alt="" src="https://github.com/MET-DEV/Django-E-Commerce/blob/master/project_images/capture_20220323080934541.jpg"></img>

##### Home Page with no login
<img alt="" src="https://github.com/MET-DEV/Django-E-Commerce/blob/master/project_images/capture_20220323080953570.jpg"></img>


##### Register Page

<img alt="" src="https://github.com/MET-DEV/Django-E-Commerce/blob/master/project_images/capture_20220323081016022.jpg"></img>


##### Login Page

<img alt="" src="https://github.com/MET-DEV/Django-E-Commerce/blob/master/project_images/capture_20220323081044867.jpg"></img>

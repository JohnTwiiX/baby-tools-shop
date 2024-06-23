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
# use touch, nano or vim
nano Dockerfile
```
```bash
# the file  should look like this
FROM python:3.9-slim

WORKDIR /app

# copy the directiory
COPY . $WORKDIR

# Install reqirements
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

WORKDIR /app/babyshop_app

RUN python manage.py makemigrations && \
    python manage.py migrate
    python manage.py collectstatic

# Start django
ENTRYPOINT ["gunicorn", "--bind", "0.0.0.0:8000", "babyshop.wsgi:application"]
```
```bash
# create image
# docker search Dockerfile alone in current project
docker build -t babyshop .

# create
docker build -t <image-name> <wherever>

# shows all
docker images

# delete one or more
docker image rm -f <image-name>
```

3. create volume for save datas
```bash
# create volume
docker volume create babyshop_data

# create
docker volume create <volume-name>

# shows all
docker volume ls

# delete one ore more
docker volume rm <volume-name>
```

4. start a docker container
```bash
# run container with image and a volume
docker run -d --name babyshop \
    -p 8025:8000 \
    -v babyshop_data:/app/babyshop_app \
    --restart on-failure \
    babyshop

# -d Run container in background and print container ID

# --name <name-of-container>

# -p <server-port>:<container-port> server-port redirect to docker-port

# -v <volume-name>:/path/to/storage

# --restart to restart the container if fails

# babyshop ist the created image
```

5. now you can see it in browser
```bash
<server-ip>:<port>
```

6. create superuser in container
```bash
# find the container id
docker ps -a

# connect to your running container
docker exec -it <container-id> python manage.py createsuperuser

# then create your super user with
# username
# email (can be empty)
# password
```

### Hints

This section will cover some hot tips when trying to interacting with this repository:

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

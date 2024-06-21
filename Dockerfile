FROM python:3.9-slim

WORKDIR /app

# copy the directiory
COPY . $WORKDIR

# Install reqirements
RUN pip install --upgrade pip && \
pip install Django==4.0.2 gunicorn==20.1.0 Pillow 

WORKDIR /app/babyshop_app

RUN python manage.py makemigrations && \ 
python manage.py migrate

# Start django
ENTRYPOINT ["gunicorn", "--bind", "0.0.0.0:8000", "babyshop.wsgi:application"]

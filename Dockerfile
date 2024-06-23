FROM python:3.9-slim

WORKDIR /app

# copy the directiory
COPY . $WORKDIR

# Install reqirements
RUN pip install --upgrade pip && \
    pip install -r requirements.txt 

WORKDIR /app/babyshop_app

RUN python manage.py makemigrations && \ 
    python manage.py migrate && \
    python manage.py collectstatic

# Start django
ENTRYPOINT ["gunicorn", "--bind", "0.0.0.0:8000", "babyshop.wsgi:application"]

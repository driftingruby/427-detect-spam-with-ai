FROM python:3.11.6

RUN apt update && apt upgrade -y

WORKDIR /app
COPY . /app
RUN pip install --no-cache-dir -r requirements.txt

ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility

EXPOSE 5000

CMD ["gunicorn -w 2 -b 0.0.0.0:5000 web:app"]

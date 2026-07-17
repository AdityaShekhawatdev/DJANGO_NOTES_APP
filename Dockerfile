# Builder stage

FROM python:3.12 AS builder

WORKDIR /app

RUN apt-get update \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*


RUN python -m venv /opt/venv

ENV PATH="/opt/venv/bin:$PATH"


COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

# Final stage

FROM python:3.12

WORKDIR /app

COPY --from=builder /opt/venv /opt/venv

ENV PATH="/opt/venv/bin:$PATH"

COPY . .

EXPOSE 8000

RUN python manage.py collectstatic --noinput

CMD [ "gunicorn", "notesapp.wsgi:application", "--bind", "0.0.0.0:8000"]
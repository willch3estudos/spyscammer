FROM python:3.9-slim AS base

WORKDIR /app

RUN pip install poetry

COPY . /app

EXPOSE 8000

RUN poetry config virtualenvs.create false
RUN poetry install --no-dev

FROM base AS app-dev

RUN apt update && apt upgrade -y && apt install git make zsh curl vim ssh -y

RUN poetry install

# For Deployment
FROM base as release
ENV LOG_LEVEL=INFO

CMD python ./app/__main__.py
ARG pyversion=3.10
FROM python:${pyversion}-bullseye
ARG pyversion=3.10
ENV PYVERSION ${pyversion:-3.10}

# Prepare virtualenv
RUN mkdir -p /app/log
RUN python -m venv /app/virtualenv
RUN /app/virtualenv/bin/pip install --upgrade pip setuptools "uvicorn[standard]"
COPY ./logging.yml /app/logging.yml
COPY ./run-uvicorn.sh /app/run-uvicorn.sh

# Install requirements
ONBUILD COPY ./requirements.txt /app/requirements.txt
ONBUILD RUN /app/virtualenv/bin/pip --disable-pip-version-check install -q -r /app/requirements.txt

# Run gunicorn
WORKDIR /app
EXPOSE 80
ENTRYPOINT ["/bin/bash", "/app/run-uvicorn.sh"]

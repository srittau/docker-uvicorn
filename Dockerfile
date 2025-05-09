ARG pyversion=3.13
FROM python:${pyversion}
ARG pyversion=3.13
ENV PYVERSION=${pyversion:-3.13}

# Prepare virtualenv
RUN mkdir -p /app/log
RUN python -m venv /app/virtualenv
RUN /app/virtualenv/bin/pip install --upgrade pip setuptools "uvicorn[standard]"
COPY ./logging.yml /app/logging.yml
COPY ./run-uvicorn.sh /app/run-uvicorn.sh

# Run uvicorn
WORKDIR /app
EXPOSE 80
ENTRYPOINT ["/bin/bash", "/app/run-uvicorn.sh"]

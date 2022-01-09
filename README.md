# docker-uvicorn

A docker base container that runs a uvicorn application server for Python.

If a `requirements.txt` file exists in the top-level directory, the
packages listed there are installed into the generated container.

## Configuration

The number of workers to start can be configured using the `UVICORN_WORKERS`
environment variable. It defaults to 4.

The uvicorn logs are written to stdout, but also stored in two files
in `/app/log` inside the container, named `access.log` and `error.log`.

## Example Dockerfile

Suppose your application lives in `src/flubber` and you have a package
called `flubber.app` that contains an ASGI application with entrypoint
`application`. The following `Dockerfile` will create an uvicorn image
running that application:

```
FROM srittau/uvicorn:latest
COPY ./src/flubber /app/flubber
CMD ["flubber.app:application"]
```

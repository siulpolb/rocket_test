FROM python:3.9-alpine

RUN mkdir /app

COPY ./pregunta_3/requirements.txt /app

RUN apk add --no-cache --virtual .build-deps \
    ca-certificates gcc linux-headers musl-dev \
    libffi-dev zlib-dev \
    && pip install -r /app/requirements.txt \
    && find /usr/local \
        \( -type d -a -name test -o -name tests \) \
        -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
        -exec rm -rf '{}' + \
    && runDeps="$( \
        scanelf --needed --nobanner --recursive /usr/local \
                | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
                | sort -u \
                | xargs -r apk info --installed \
                | sort -u \
    )" \
    && apk add --virtual .rundeps $runDeps \
    && apk del .build-deps


COPY ./pregunta_3/ /app
WORKDIR /app

CMD [ "python", "manage.py", "runserver", "0.0.0.0:8000" ]

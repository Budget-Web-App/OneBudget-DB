FROM postgres:latest

RUN apt-get -y update \
    && apt-get install -y build-essential gettext libpq-dev\
    && apt-get install -y wkhtmltopdf\
    && apt-get install -y gdal-bin\
    && apt-get install -y libgdal-dev\
    && apt-get install -y --no-install-recommends software-properties-common\
    && apt-add-repository contrib\
    && apt-get update \
    && apt-get install -y openssl \
    && rm -rf /var/lib/apt/lists/*

#RUN apk add --no-cache ca-certificates \
#    && apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community vault

ENV POSTGRES_USER=accountsadmin
ENV POSTGRES_PASSWORD=adminpassword
ENV POSTGRES_DB=accountsdb
ENV DATABASE_POOL_SIZE=10
ENV password_encryption=md5

# Files for initializing the database.
COPY initdb/0-accounts-schema.sql /docker-entrypoint-initdb.d/0-accounts-schema.sql

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 5432

CMD ["postgres"]

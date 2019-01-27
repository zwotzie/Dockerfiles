# https://github.com/docker-library/mariadb/blob/master/10.3/Dockerfile

FROM base_mariadb:10.3

COPY docker-entrypoint-initdb.d/*.sql docker-entrypoint-initdb.d/

ADD boot.sh /

CMD ["/boot.sh"]

FROM ubuntu

RUN apt-get update \
 && apt-get install -y \
    nginx \
 && apt-get autoremove -y --purge \
 && apt-get clean \
 && ln -sfv /dev/stdout /var/log/nginx/access.log \
 && ln -sfv /dev/stderr /var/log/nginx/error.log

COPY nginx.conf /etc/nginx/.
COPY . /var/www/html/.

RUN chown -R 1001:0 /run /var/lib/nginx \
 && chmod -R g=u    /run /var/lib/nginx /etc/passwd

EXPOSE 8080

USER 1001:0

CMD ["nginx"]

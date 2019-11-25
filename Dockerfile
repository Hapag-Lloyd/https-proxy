# load nginx image
FROM nginx:1.17.6-alpine

# update and install openssl
RUN apk update && \
    apk upgrade && \
    apk add openssl

# change ownership to user nginx, copy files and create directories
RUN mkdir /tmp/nginx
COPY default.conf /etc/nginx/conf.d/
COPY nginx.conf /etc/nginx/
COPY entrypoint.sh /tmp/nginx/
RUN chown -R nginx:nginx /etc/nginx/ /var/cache/nginx/ /tmp/nginx/ /var/run/

# run initial script
USER nginx

ENTRYPOINT ["/tmp/nginx/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]

# Stage 1: Assets stage
FROM scratch AS assets
COPY icons /icons
COPY theme /theme
COPY custom /custom

# Stage 2: Nginx server
FROM ghcr.io/nginx/nginx-unprivileged:1.31.8

ENV NGINX_ENTRYPOINT_LOCAL_RESOLVERS=1
ENV PORT=8080
ENV NGINX_ENVSUBST_FILTER="^(NGINX_LOCAL_RESOLVERS|PORT)$"

WORKDIR /usr/share/nginx/html

COPY --from=assets / ./
COPY default.conf.template /etc/nginx/templates/default.conf.template

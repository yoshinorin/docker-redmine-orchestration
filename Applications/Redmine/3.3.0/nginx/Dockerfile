#https://github.com/YoshinoriN/docker-nginx/tree/master/1.11.4/Alpine
FROM alpine:3.4

MAINTAINER YoshinoriN

ENV NGINX_VERSION=1.11.4

RUN apk --no-cache update \
  && apk --no-cache add --virtual build-dependencies curl build-base openssl-dev \
  && apk --no-cache add pcre-dev libxslt-dev gd-dev geoip-dev \
  && curl -O -s http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz \
  && tar xvfz nginx-${NGINX_VERSION}.tar.gz \
  && addgroup -S nginx \
  && adduser -D -S -h /var/cache/nginx -s /sbin/nologin -G nginx nginx \
  && cd nginx-${NGINX_VERSION} \
  && ./configure \
       --prefix=/usr/share/nginx \
       --conf-path=/etc/nginx/nginx.conf \
       --http-log-path=/var/log/nginx/access.log \ 
       --error-log-path=/var/log/nginx/error.log \
       --lock-path=/var/lock/nginx.lock \
       --pid-path=/run/nginx.pid \
       --http-client-body-temp-path=/var/lib/nginx/body \ 
       --http-fastcgi-temp-path=/var/lib/nginx/fastcgi \
       --http-proxy-temp-path=/var/lib/nginx/proxy \
       --http-scgi-temp-path=/var/lib/nginx/scgi \
       --http-uwsgi-temp-path=/var/lib/nginx/uwsgi \ 
       --with-debug \
       --with-pcre-jit \
       --with-ipv6 \
       --with-http_ssl_module \
       --with-http_stub_status_module \
       --with-http_realip_module \
       --with-http_auth_request_module \
       --with-http_addition_module \
       --with-http_dav_module \
       --with-http_geoip_module \
       --with-http_gunzip_module \
       --with-http_gzip_static_module \
       --with-http_image_filter_module \
       --with-http_v2_module \
       --with-http_sub_module \
       --with-http_xslt_module \
       --with-stream \
       --with-stream_ssl_module \
       --with-mail \
       --with-mail_ssl_module \ 
       --with-threads \
  && make \
  && make install \
  && ln -sf /dev/stdout /var/log/nginx/access.log \
  && ln -sf /dev/stderr /var/log/nginx/error.log \
  && cd / \
  && mkdir /var/lib/nginx \
  && apk del --purge build-dependencies \
  && rm nginx-${NGINX_VERSION}.tar.gz \
  && rm -rf nginx-${NGINX_VERSION} \
  && rm -rf /var/cache/apk/*

COPY nginx.conf /etc/nginx/nginx.conf
VOLUME /var/log/nginx/

EXPOSE 80 443

CMD ["usr/share/nginx/sbin/nginx", "-g", "daemon off;"]

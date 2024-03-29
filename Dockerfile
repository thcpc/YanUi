FROM node:14.21-alpine as node_buidler
RUN mkdir /ng-app
WORKDIR /ng-app
COPY . .
RUN npm install --registry=https://registry.npm.taobao.org
RUN node_modules/.bin/ng build 


FROM nginx
# RUN apk add gettext

# COPY config/nginx/start-nginx.sh /usr/bin/start-nginx.sh
COPY deploy/nginx/default.conf /etc/nginx/conf.d/default.conf

# RUN chmod +x /usr/bin/start-nginx.sh
COPY --from=node_buidler /ng-app/dist/yan/ /usr/share/nginx/html/
# CMD [“nginx”, “-g”,“daemon off;”]
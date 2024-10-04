FROM node:14 AS build

WORKDIR /app
COPY package.json ./

RUN npm install
COPY .eslintrc.js ./
COPY public ./public
COPY src ./src
COPY vue.config.js ./
COPY .babelrc-lib ./
COPY babel.config.js ./
RUN npm run build-app

FROM nginx:1.27.2 AS production

COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build /app/dist /usr/share/nginx/html/primevue

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]

FROM node:16-alpine as builder
WORKDIR /app
COPY ./package.json .
COPY ./yarn.lock .
RUN yarn install
COPY . .
ARG TMDB_V3_API_KEY
ENV VITE_APP_TMDB_V3_API_KEY="0a5c76f39b37918e45f6a8e56b8509c5"
ENV VITE_APP_API_ENDPOINT_URL="https://api.themoviedb.org/3"
#RUN yarn add lodash@2.4.2
RUN yarn build


FROM nginx:stable-alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=builder /app/dist .
EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]

#FROM openjdk:8 #Introducir vulnerabilidad para break de Trivy




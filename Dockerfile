# For prod, we want the build files served by the NGINX proxy
# Use a multi step build to pass the build outputs to the NGINX build step

# Build Front end Phase
FROM node:18-alpine as build
EXPOSE 80
WORKDIR /app

COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# NGINX Phase
FROM nginx
COPY --from=build /app/build /usr/share/nginx/html

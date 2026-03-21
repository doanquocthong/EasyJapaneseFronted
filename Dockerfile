# ====== BUILD STAGE ======
FROM node:18-alpine AS build

WORKDIR /app

# copy package trước để cache
COPY package*.json ./

RUN npm install

# copy toàn bộ source
COPY . .

# build project
RUN npm run build


FROM nginx:alpine

COPY --from=build /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
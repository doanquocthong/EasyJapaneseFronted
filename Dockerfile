FROM node:20

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

# Copy env production nếu dùng VITE_API_URL
COPY .env.production .env

RUN npm run build

CMD ["npx", "serve", "dist"]
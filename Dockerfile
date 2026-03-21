FROM node:18

WORKDIR /app

# Copy package files
COPY package*.json ./

# Cài cả devDependencies
RUN npm install

# Copy source code
COPY . .

# Copy file env production để build Vite production
COPY .env.production .env

# Build
RUN npm run build

# Start (ví dụ dùng serve)
CMD ["npx", "serve", "dist"]
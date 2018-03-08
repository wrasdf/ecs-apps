FROM node:carbon-slim

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

EXPOSE 3000
ENTRYPOINT ["npm", "start"]

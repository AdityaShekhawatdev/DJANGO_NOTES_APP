FROM node:22-alpine AS builder

WORKDIR /app

COPY package*.json .

RUN npm install

COPY . .

# Final stage

FROM node:22-alpine

WORKDIR /app

COPY --from=builder /app .

EXPOSE 3000

CMD [ "npm", "run", "build"  ]



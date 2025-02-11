FROM node:18-alpine 

WORKDIR /user/app

COPY package.json ./

RUN npm install

COPY . .

ARG MONGO_URI
ARG JWT_SECRET

ENV MONGO_URI=$MONGO_URI
ENV JWT_SECRET=$JWT_SECRET

RUN echo "MONGO_URI=${MONGO_URI}" > .env 
RUN echo "JWT_SECRET=${JWT_SECRET}" > .env

RUN npm install -g pnpm

RUN pnpm build

EXPOSE 3010

CMD ["node", "dist/main"]
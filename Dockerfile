FROM node:20.12.0-alpine3.19

WORKDIR /usr/src/app

COPY package.json yarn.lock tsconfig.json .
COPY ./prisma .

# Install dependencies
RUN yarn install
# Can you add a script to the global package.json that does this?
RUN yarn prisma generate

COPY . .

# Can you filter the build down to just one app?
RUN yarn build

CMD ["node", "dist/index.js"]
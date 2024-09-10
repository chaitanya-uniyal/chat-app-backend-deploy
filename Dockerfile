# Use Node.js base image
FROM node:20.12.0-alpine3.19

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy necessary files for installing dependencies
COPY package.json yarn.lock tsconfig.json ./
COPY ./prisma ./prisma

# Set the DATABASE_URL environment variable
# This should be done before generating Prisma client files
ENV DATABASE_URL=""
ENV JWT_SECRET=""
ENV REDIS_HOST=""
ENV REDIS_USERNAME=""
ENV REDIS_PASSWORD=""


# Install dependencies
RUN yarn install

# Generate Prisma client based on the provided DATABASE_URL
RUN yarn prisma generate

# Copy the rest of the application code
COPY . .

# Build the application
RUN yarn build

# Start the application
CMD ["node", "dist/index.js"]

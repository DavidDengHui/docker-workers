# Use the official Node.js image as the base image
FROM node:16

# Set the working directory
WORKDIR /app

# Copy the package.json and package-lock.json files
COPY package*.json ./

# Install the dependencies
RUN npm install

# Copy the worker.js file
COPY worker.js ./

# Install and set libc++.so.1
RUN apt-get update && apt-get install -y libc++-dev

# Expose port 3000
EXPOSE 3000

# Start the workerd server
CMD ["npx", "workerd", "worker.js", "localhost", "3000"]

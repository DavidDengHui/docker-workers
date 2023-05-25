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

# Install and set libc++.so.1 and libunwind.so.1
RUN apt-get update && apt-get install -y libc++-dev libunwind-dev

# Set the default port to 80
ENV PORT 80

# Expose the port specified by the PORT environment variable
EXPOSE $PORT

# Start the workerd server on the port specified by the PORT environment variable
CMD ["npx", "workerd", "worker.js", "localhost", "$PORT"]

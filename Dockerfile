# Use the official Node.js image as the base image
FROM ubuntu

# Set the working directory
WORKDIR /my-worker

RUN cd /my-worker && apt-get update && apt-get install -y nodejs npm

# Copy the package.json and package-lock.json files
COPY package.json ./

# Copy the worker.js file
COPY worker.js ./

# Install the dependencies
RUN npm init -y && npm install cloudflare-worker-local

# Set the default port to 80
ENV PORT 80

# Expose the port specified by the PORT environment variable
EXPOSE $PORT

# Start the workerd server on the port specified by the PORT environment variable
CMD ["npx", "cloudflare-worker-local", "worker.js", "localhost", "$PORT"]

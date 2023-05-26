# Use the official Node.js 16 image
FROM node:16

# Create and change to the app directory
WORKDIR /usr/src/app

# Copy the worker.js file
COPY worker.js .

# Install Miniflare 2.0 globally
RUN npm install -g miniflare

# Expose port 8787
EXPOSE 8787

# Run Miniflare 2.0 on port 8787
CMD ["miniflare", "worker.js", "-p", "8787"]

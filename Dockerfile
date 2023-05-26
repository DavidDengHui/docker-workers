FROM ubuntu
RUN apt-get update && apt-get install -y nodejs npm
RUN npm init -y && npm install -g miniflare

# Set the working directory
WORKDIR /usr/src/app

# Copy the worker.js file
COPY worker.js ./

Set the default port
ENV PORT 8080

Expose the port specified by the PORT environment variable
EXPOSE $PORT

# Run Miniflare 2.0 on port 8787
CMD ["miniflare", "worker.js", "-p", "$PORT"]

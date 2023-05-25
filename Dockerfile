# Use centos7 as base image
FROM centos:7

# Install curl, nodejs and npm
RUN yum install -y curl
RUN curl -sL https://rpm.nodesource.com/setup_14.x | bash -
RUN yum install -y nodejs

# Install @cloudflare/wrangler globally
RUN npm install -g @cloudflare/wrangler

# Copy worker.js file to container
COPY worker.js /worker.js

# Generate and publish worker using wrangler
RUN wrangler generate my-worker
RUN cp /worker.js /my-worker/index.js
RUN wrangler publish --env production

# Install nginx and configure it to proxy worker to port 80
RUN yum install -y nginx
RUN echo 'server { listen 80; location / { proxy_pass http://127.0.0.1:8787; } }' > /etc/nginx/conf.d/default.conf

# Start nginx
CMD ["nginx", "-g", "daemon off;"]

# 使用node 16作为基础镜像
FROM node:16

# 安装cloudflare-worker-local
RUN npm install -g cloudflare-worker-local

# 创建工作目录
WORKDIR /app

# 复制worker.js文件到工作目录
COPY worker.js .

# 暴露端口
EXPOSE 80
EXPOSE 3000
EXPOSE 4000

# 运行cloudflare-worker-local命令，指定worker.js文件和端口号
RUN cloudflare-worker-local ./worker.js localhost:3000 4000

# Install nginx and configure it to proxy worker to port 80
RUN yum install -y nginx
RUN echo 'server { listen 80; location / { proxy_pass http://127.0.0.1:4000; } }' > /etc/nginx/conf.d/default.conf

# Start nginx
CMD ["nginx", "-g", "daemon off;"]

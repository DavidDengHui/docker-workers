# 使用node 16作为基础镜像
FROM node:16

# 安装cloudflare-worker-local
RUN npm install -g cloudflare-worker-local

# 创建工作目录
WORKDIR /app

# 复制worker.js文件到工作目录
COPY worker.js .

# 暴露80端口
EXPOSE 4000

# 运行cloudflare-worker-local命令，指定worker.js文件和端口号
CMD ["cloudflare-worker-local", "worker.js", "localhost:3000", "4000"]

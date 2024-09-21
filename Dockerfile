# 使用 Ubuntu 作为基础镜像
FROM ubuntu:latest

# 更新软件包列表并安装字体
RUN apt-get update && \
    apt-get install -y fonts-noto-cjk fonts-noto-color-emoji ttf-wqy-zenhei ttf-wqy-microhei && \
    apt-get clean

# 设置默认语言环境
ENV LANG zh_CN.UTF-8
ENV LANGUAGE zh_CN:zh
ENV LC_ALL zh_CN.UTF-8

# 安装 locales 包并生成中文 locale
RUN apt-get install -y locales && \
    locale-gen zh_CN.UTF-8 && \
    update-locale LANG=zh_CN.UTF-8
    
RUN apt install python3 python3-pip -y 
RUN apt install python3-flask python3-cairosvg python3-pillow -y

# 设置工作目录
WORKDIR /app

# 复制应用程序文件（如果有）
COPY code2png.py /app

EXPOSE 5000

# 设置启动命令（根据实际需求修改）
CMD ["python3", "code2png.py"]


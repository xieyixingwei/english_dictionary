FROM python:3.8.5

MAINTAINER GaoNian

# 设置 python 环境变量
ENV PYTHONUNBUFFERED 1
ENV SITE_FOLDER django_prj

ENV MY_PROXY_URL="192.168.1.10:8118"
ENV HTTP_PROXY=$MY_PROXY_URL \
    HTTPS_PROXY=$MY_PROXY_URL \
    FTP_PROXY=$MY_PROXY_URL \
    http_proxy=$MY_PROXY_URL \
    https_proxy=$MY_PROXY_URL \
    ftp_proxy=$MY_PROXY_URL

# 设置pip源为国内源
COPY ./pip.conf /root/.pip/pip.conf

# 在容器内/var/www/html/下创建站点文件夹
RUN mkdir -p /var/www/html/$SITE_FOLDER

# 设置容器内工作目录
WORKDIR /var/www/html/$SITE_FOLDER

# 将目录文件加入到容器工作目录中
# COPY ./server /var/www/html/$SITE_FOLDER

# 更新pip版本
RUN python3 -m pip install --upgrade pip

# 利用 pip 安装依赖
COPY ./requirements.txt /var/www/html/$SITE_FOLDER
RUN pip3 install -r requirements.txt

ENTRYPOINT ["sh", "start_docker.sh"]

#!/bin/bash
# 从第一行到最后一行分别表示：
# 1. 收集静态文件到根目录
# 2. 生产数据库迁移文件
# 3. 根据数据库迁移文件来修改数据库
# 4. 用 uwsgi启动 django 服务, 不再使用python manage.py runserver

python3 ./server/manage.py collectstatic --noinput&&
python3 ./server/manage.py makemigrations&&
python3 ./server/manage.py migrate&&
uwsgi --ini uwsgi_docker.ini

# never exit，此处是为了运行完上条应用服务后，有对应的前台进程
tail -f /dev/null

# -*- coding:utf-8 -*-

# 自己创建的本地配置文件

LANGUAGE_CODE = 'zh-hans'
TIME_ZONE = 'Asia/Shanghai'

# 配置数据库缓存表
CACHES = {
    'default':{
        'BACKEND': 'django.core.cache.backends.db.DatabaseCache',
        'LOCATION': 'MyCacheTable',
        'TIMEOUT': 5 * 60, # 缓存的默认过期时间，单位秒
    },
    'redis':{
        'BACKEND': 'django_redis.cache.RedisCache',
        'LOCATION': 'redis://127.0.0.1:6378/1',
        'OPTIONS': {
            'CLIENT_CLASS': 'django_redis.client.DefaultClient',
        }
    },
}

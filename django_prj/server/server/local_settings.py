# -*- coding:utf-8 -*-

# 自己创建的本地配置文件

LANGUAGE_CODE = 'zh-hans'
TIME_ZONE = 'Asia/Shanghai'

# 配置数据库缓存表
CACHES = {
    'default':{
        'BACKEND': 'django.core.cache.backends.db.DatabaseCache',
        'LOCATION': 'cache_table',
        'TIMEOUT': 24 * 60 * 60, # 缓存的默认过期时间，单位秒
    },
    'redis':{
        'BACKEND': 'django_redis.cache.RedisCache',
        'LOCATION': 'redis://127.0.0.1:6378/1',
        'OPTIONS': {
            'CLIENT_CLASS': 'django_redis.client.DefaultClient',
        }
    },
}

CORS_ORIGIN_ALLOW_ALL = True
CORS_ALLOW_CREDENTIALS = True

LOGIN_TIMEOUT = 24 * 60 * 60


REST_FRAMEWORK = {
    'DEFAULT_AUTHENTICATION_CLASSES': (
        # 'rest_framework.authentication.BasicAuthentication',
        # 'rest_framework.authentication.SessionAuthentication',
        # 'rest_framework.authentication.TokenAuthentication',
        'server.authentication.TokenAuthentication',
    ),
    'DEFAULT_PERMISSION_CLASSES':(
        # 'rest_framework.permissions.IsAuthenticated', # IsAuthenticated 仅通过认证的用户
        # 'rest_framework.permissions.AllowAny',          # AllowAny 允许所有用户
        # 'rest_framework.permissions.IsAdminUser',     # IsAdminUser 仅管理员用户
        # 'rest_framework.permissions.IsAuthenticatedOrReadOnly', # IsAuthenticatedOrReadOnly 认证的用户可以完全操作，
                                                                  #  否则只能get读取
        'server.permissions.AllowAny',
    ),
    'DEFAULT_FILTER_BACKENDS': (
        'django_filters.rest_framework.DjangoFilterBackend',
    ),
}

ROOT_USERS = ['root']

# -*- coding:utf-8 -*-

# 自己创建的本地配置文件
from pathlib import Path

# Build paths inside the project like this: BASE_DIR / 'subdir'.
BASE_DIR = Path(__file__).resolve().parent.parent


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

ROOT_USERS = ['root', 'admin']

# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/3.1/howto/static-files/

STATIC_ROOT = BASE_DIR / 'static'
STATIC_URL = '/static/'

STATICFILES_DIRS = [
    BASE_DIR / 'media',
]

# 动态文件存放路径
MEDIA_ROOT = BASE_DIR / 'media' # 动态文件存放的根路径
MEDIA_URL = '/media/' # 动态文件的URL

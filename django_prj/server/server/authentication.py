from django.core.cache import cache
from rest_framework import authentication
from rest_framework import request
from user.models import UserTable


class TokenAuthentication(authentication.BaseAuthentication):
    """
    Token 认证
    """
    def authenticate(self, request:request.Request):
        token = request.query_params.get('token')
        if not token:
            token = request.headers.get('authorization')

        try:
            id = cache.get(token)
            user = UserTable.objects.get(pk=id)
            user.is_authenticated = True
            return user, token # 认证成功返回一个元组(user, token)
        except:
            return None # 认证失败返回None

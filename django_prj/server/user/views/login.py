from rest_framework import serializers, exceptions, views, generics, response, request, status
from rest_framework.decorators import action
from rest_framework import mixins, viewsets
from django.core.cache import cache
from user.models import User
from server.settings import LOGIN_TIMEOUT, ROOT_USERS
import uuid
from server import permissions


class LoginSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('u_id','u_uname','u_passwd')


# 登陆 path/login/
class LoginView(generics.CreateAPIView):
    '''
    登陆
    '''
    serializer_class = LoginSerializer
    queryset = User.objects.all()
    permission_classes = (permissions.AllowAny,) # 允许所有用户

    def post(self, request, *args, **kwargs):
        u_uname = request.data.get('u_uname')
        u_passwd = request.data.get('u_passwd')
        try:
            user = User.objects.get(u_uname=u_uname)
            if user.u_passwd != u_passwd:
                return response.Response({'status': 0,
                                          'msg': '用户名或密码不对!'})
            token = uuid.uuid4().hex
            cache.set(token, user.u_id, timeout=LOGIN_TIMEOUT) # 往缓存里添加数据
            data = {
                'msg': 'login success',
                'status': 200,
                'token': token}
            return response.Response(data)
        except User.DoesNotExist:
            raise exceptions.NotFound
        raise exceptions.ValidationError



'''
    def post(self, request, *args, **kwargs):
        u_uname = request.data.get('u_uname')
        u_passwd = request.data.get('u_passwd')
        user = auth.authenticate(username=u_uname, password=u_passwd)
        if not user:
            return response.Response({'status': 0,
                                     'msg': '用户名或密码不对!'})
        # 删除原有的Token
        old_token = Token.objects.filter(user=user)
        old_token.delete()
        # 创建新的Token
        token = Token.objects.create(user=user)
        return response.Response({
                                'status': 200,
                                'msg': 'login success',
                                'token': token.key})
'''

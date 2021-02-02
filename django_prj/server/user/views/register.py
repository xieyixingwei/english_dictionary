from rest_framework import serializers, exceptions, views, generics, response, request, status
from rest_framework.decorators import action
from rest_framework import mixins, viewsets
from rest_framework import permissions, authentication
from django.core.cache import cache
from user.models import User
from server.settings import LOGIN_TIMEOUT, ROOT_USERS
from server import permissions
import uuid


class RegisterSerializer(serializers.ModelSerializer):

    class Meta:
        model = User
        fields = ('u_id','u_uname','u_passwd')


# 注册 path/register/
class RegisterView(generics.CreateAPIView):
    serializer_class = RegisterSerializer
    queryset = User.objects.all()
    permission_classes = (permissions.AllowAny,) # 允许所有用户

    # 重写create()
    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        self.perform_create(serializer)
        # 将root用户自动设为管理员
        data = serializer.data
        if data["u_uname"] in ROOT_USERS:
            u_id= data["u_id"]
            user = User.objects.get(pk=u_id)
            user.u_is_admin = True
            user.save()
            data["u_is_admin"] = True
        headers = self.get_success_headers(data)
        return response.Response(data, status=status.HTTP_201_CREATED, headers=headers)


class CreateAdminUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('u_id','u_uname','u_passwd')

    def validate(self, attrs):
        attrs['u_is_admin'] = True
        return attrs


class CreateAdminUserView(generics.CreateAPIView):
    serializer_class = CreateAdminUserSerializer
    queryset = User.objects.all()
    permission_classes = (permissions.IsRootUser,)

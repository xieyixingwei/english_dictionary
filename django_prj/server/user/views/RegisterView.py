from rest_framework import serializers, generics
from rest_framework import permissions
from user.models import UserTable
from server import permissions


class RegisterSerializer(serializers.ModelSerializer):

    class Meta:
        model = UserTable
        fields = ('id','uname','passwd')


# 注册 path/register/
class RegisterView(generics.CreateAPIView):
    serializer_class = RegisterSerializer
    queryset = UserTable.objects.all()
    permission_classes = (permissions.AllowAny,) # 允许所有用户


class CreateAdminUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserTable
        fields = ('id','uname','passwd')

    def validate(self, attrs):
        attrs['isAdmin'] = True
        return attrs


class CreateAdminUserView(generics.CreateAPIView):
    serializer_class = CreateAdminUserSerializer
    queryset = UserTable.objects.all()
    permission_classes = (permissions.IsRootUser,)

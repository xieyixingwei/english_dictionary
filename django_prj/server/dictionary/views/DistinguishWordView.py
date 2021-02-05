from rest_framework import serializers, response, request, generics
from server import permissions
from dictionary.models import DistinguishWordTable
from server.views import ModelViewSetPermissionSerializerMap


class DistinguishWordSerializer(serializers.ModelSerializer):
    class Meta:
        model = DistinguishWordTable
        fields = '__all__'


class DistinguishWordView(ModelViewSetPermissionSerializerMap):
    queryset = DistinguishWordTable.objects.all()
    serializer_class = DistinguishWordSerializer
    permission_classes = (permissions.IsRootUser,)
    permission_classes_map = {
        'retrieve': (permissions.AllowAny,),
    }

from rest_framework import serializers, response, request, generics
from server import permissions
from dictionary.models import GrammarTable
from server.views import ModelViewSetPermissionSerializerMap


class GrammarSerializer(serializers.ModelSerializer):
    class Meta:
        model = GrammarTable
        fields = '__all__'


class GrammarView(ModelViewSetPermissionSerializerMap):
    queryset = GrammarTable.objects.all()
    serializer_class = GrammarSerializer
    permission_classes = (permissions.IsRootUser,)
    permission_classes_map = {
        'retrieve': (permissions.AllowAny,),
    }

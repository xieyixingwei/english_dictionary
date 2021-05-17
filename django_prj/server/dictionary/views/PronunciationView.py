from rest_framework import serializers, response, request, generics
from server import permissions
from dictionary.models.PronunciationTable import SoundmarkTable, PronunciationTable
from server.views import ModelViewSetPermissionSerializerMap as ModelViewSetPSM


class _SoundmarkSerializer(serializers.ModelSerializer):
    class Meta:
        model = SoundmarkTable
        fields = '__all__'


class SoundmarkView(ModelViewSetPSM):
    queryset = SoundmarkTable.objects.all()
    serializer_class = _SoundmarkSerializer
    permission_classes = (permissions.IsRootUser,)
    permission_classes_map = {
        'retrieve': (permissions.AllowAny,),
        'list': (permissions.AllowAny,),
    }
    lookup_field = 's_name'

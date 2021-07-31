from rest_framework import serializers

from server import permissions
from server.views import ModelViewSetPermissionSerializerMap
from dictionary.models.WordTagTable import WordTagTable


class _WordTagSerializer(serializers.ModelSerializer):
    class Meta:
        model = WordTagTable
        fields = '__all__'


class WordTagView(ModelViewSetPermissionSerializerMap):
    """
    单词 tags 视图
    """
    queryset = WordTagTable.objects.all()
    serializer_class = _WordTagSerializer
    permission_classes = (permissions.IsRootUser,)
    permission_classes_map = {
        'list': (permissions.AllowAny,),
    }

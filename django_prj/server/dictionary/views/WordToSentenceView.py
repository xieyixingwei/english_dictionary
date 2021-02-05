from rest_framework import serializers, response, request, generics
from server import permissions
from dictionary.models import WordToSentenceTable
from .SentenceView import SentenceSerializer
from server.views import ModelViewSetPermissionSerializerMap


class WordToSentenceSerializer(serializers.ModelSerializer):
    class Meta:
        model = WordToSentenceTable
        fields = '__all__'


class WordToSentenceView(ModelViewSetPermissionSerializerMap):
    queryset = WordToSentenceTable.objects.all()
    serializer_class = WordToSentenceSerializer
    permission_classes = (permissions.IsRootUser,)
    permission_classes_map = {
        'list': (permissions.AllowAny,),
    }
    filter_fields = ('wtg_word')

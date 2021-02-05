from rest_framework import serializers, response, request, generics
from server import permissions
from dictionary.models import SentenceTable
from .GrammarView import GrammarSerializer
from server.views import ModelViewSetPermissionSerializerMap


class SentenceSerializer(serializers.ModelSerializer):
    class Meta:
        model = SentenceTable
        fields = '__all__'


class _RetrieveSentenceSerializer(serializers.ModelSerializer):
    sentence_grammar = GrammarSerializer(many=True, read_only=True)
    class Meta:
        model = SentenceTable
        fields = ('__all__')


class SentenceView(ModelViewSetPermissionSerializerMap):
    """
    句子 视图
    """
    queryset = SentenceTable.objects.all()
    serializer_class = SentenceSerializer
    serializer_class_map = {
        'retrieve': _RetrieveSentenceSerializer
    }
    permission_classes = (permissions.IsRootUser,)
    permission_classes_map = {
        'retrieve': (permissions.AllowAny,),
    }


from dictionary.models import RelativeSentenceTable


class _RelativeSentenceSerializer(serializers.ModelSerializer):
    class Meta:
        model = RelativeSentenceTable
        fields = '__all__'


class RelativeSentenceView(ModelViewSetPermissionSerializerMap):
    """
    近义句/反义句 视图
    """
    queryset = RelativeSentenceTable.objects.all()
    serializer_class = _RelativeSentenceSerializer
    permission_classes = (permissions.IsRootUser,)
    permission_classes_map = {
        'retrieve': (permissions.AllowAny,),
    }
    filter_fields = ('r_sentence_a','r_sentence_b', 'r_type')

from rest_framework import serializers, response, request, generics
from server import permissions
from dictionary.models import WordTable
from .WordToSentenceView import WordToSentenceSerializer
from .GrammarView import GrammarSerializer
from .DistinguishWordView import DistinguishWordSerializer

class _WordSerializer(serializers.ModelSerializer):
    class Meta:
        model = WordTable
        fields = '__all__'


class CreateWordView(generics.CreateAPIView):
    serializer_class = _WordSerializer
    queryset = WordTable.objects.all()
    permission_classes = (permissions.IsRootUser,)


class UpdateWordView(generics.UpdateAPIView):
    serializer_class = _WordSerializer
    queryset = WordTable.objects.all()
    permission_classes = (permissions.IsRootUser,)
    lookup_field = 'w_name'


class _WordRetrieveSerializer(serializers.ModelSerializer):
    sentences = WordToSentenceSerializer(many=True, read_only=True)
    word_grammar = GrammarSerializer(many=True, read_only=True)
    distinguish = DistinguishWordSerializer(many=True, read_only=True)
    class Meta:
        model = WordTable
        fields = ('__all__')


class RetrieveWordView(generics.RetrieveAPIView):
    serializer_class = _WordRetrieveSerializer
    queryset = WordTable.objects.all()
    permission_classes = (permissions.AllowAny,)
    lookup_field = 'w_name'

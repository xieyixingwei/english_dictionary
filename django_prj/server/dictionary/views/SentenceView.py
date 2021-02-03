from rest_framework import serializers, response, request, generics
from server import permissions
from dictionary.models import SentenceTable
from .GrammarView import GrammarSerializer


class SentenceSerializer(serializers.ModelSerializer):
    class Meta:
        model = SentenceTable
        fields = '__all__'


class CreateSentenceView(generics.CreateAPIView):
    serializer_class = SentenceSerializer
    queryset = SentenceTable.objects.all()
    permission_classes = (permissions.IsRootUser,)


class UpdateSentenceView(generics.UpdateAPIView):
    serializer_class = SentenceSerializer
    queryset = SentenceTable.objects.all()
    permission_classes = (permissions.IsRootUser,)


class _RetrieveSentenceSerializer(serializers.ModelSerializer):
    sentence_grammar = GrammarSerializer(many=True, read_only=True)
    class Meta:
        model = SentenceTable
        fields = ('__all__')


class RetrieveSentenceView(generics.RetrieveAPIView):
    serializer_class = _RetrieveSentenceSerializer
    queryset = SentenceTable.objects.all()
    permission_classes = (permissions.AllowAny,)

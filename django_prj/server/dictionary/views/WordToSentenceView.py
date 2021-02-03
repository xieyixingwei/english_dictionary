from rest_framework import serializers, response, request, generics
from server import permissions
from dictionary.models import WordToSentenceTable
from .SentenceView import SentenceSerializer


class WordToSentenceSerializer(serializers.ModelSerializer):
    class Meta:
        model = WordToSentenceTable
        fields = '__all__'


class CreateWordToSentenceView(generics.CreateAPIView):
    serializer_class = WordToSentenceSerializer
    queryset = WordToSentenceTable.objects.all()
    permission_classes = (permissions.IsRootUser,)


class UpdateWordToSentenceView(generics.UpdateAPIView):
    serializer_class = WordToSentenceSerializer
    queryset = WordToSentenceTable.objects.all()
    permission_classes = (permissions.IsRootUser,)


class ListWordToSentenceView(generics.ListAPIView):
    serializer_class = WordToSentenceSerializer
    queryset = WordToSentenceTable.objects.all()
    permission_classes = (permissions.AllowAny,)
    lookup_field = 'wtg_word'

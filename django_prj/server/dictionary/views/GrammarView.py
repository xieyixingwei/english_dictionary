from rest_framework import serializers, response, request, generics
from server import permissions
from dictionary.models import GrammarTable


class GrammarSerializer(serializers.ModelSerializer):
    class Meta:
        model = GrammarTable
        fields = '__all__'


class CreateGrammarView(generics.CreateAPIView):
    serializer_class = GrammarSerializer
    queryset = GrammarTable.objects.all()
    permission_classes = (permissions.IsRootUser,)


class UpdateGrammarView(generics.UpdateAPIView):
    serializer_class = GrammarSerializer
    queryset = GrammarTable.objects.all()
    permission_classes = (permissions.IsRootUser,)


class RetrieveGrammarView(generics.RetrieveAPIView):
    serializer_class = GrammarSerializer
    queryset = GrammarTable.objects.all()
    permission_classes = (permissions.AllowAny,)

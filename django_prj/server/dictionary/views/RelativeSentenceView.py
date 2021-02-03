from rest_framework import serializers, response, request, generics
from server import permissions
from dictionary.models import RelativeSentenceTable


class _RelativeSentenceSerializer(serializers.ModelSerializer):
    class Meta:
        model = RelativeSentenceTable
        fields = '__all__'


class CreateRelativeSentenceView(generics.CreateAPIView):
    serializer_class = _RelativeSentenceSerializer
    queryset = RelativeSentenceTable.objects.all()
    permission_classes = (permissions.IsRootUser,)


class UpdateRelativeSentenceView(generics.UpdateAPIView):
    serializer_class = _RelativeSentenceSerializer
    queryset = RelativeSentenceTable.objects.all()
    permission_classes = (permissions.IsRootUser,)


class ListRelativeSentenceView(generics.ListAPIView):
    serializer_class = _RelativeSentenceSerializer
    queryset = RelativeSentenceTable.objects.all()
    permission_classes = (permissions.AllowAny,)
    lookup_field = 'r_sentence_a'

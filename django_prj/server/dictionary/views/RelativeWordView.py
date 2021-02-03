from rest_framework import serializers, response, request, generics
from server import permissions
from dictionary.models import RelativeWordTable


class _RelativeWordSerializer(serializers.ModelSerializer):
    class Meta:
        model = RelativeWordTable
        fields = '__all__'


class CreateRelativeWordView(generics.CreateAPIView):
    serializer_class = _RelativeWordSerializer
    queryset = RelativeWordTable.objects.all()
    permission_classes = (permissions.IsRootUser,)


class UpdateRelativeWordView(generics.UpdateAPIView):
    serializer_class = _RelativeWordSerializer
    queryset = RelativeWordTable.objects.all()
    permission_classes = (permissions.IsRootUser,)


class ListRelativeWordView(generics.ListAPIView):
    serializer_class = _RelativeWordSerializer
    queryset = RelativeWordTable.objects.all()
    permission_classes = (permissions.AllowAny,)
    lookup_field = 'r_word_a'

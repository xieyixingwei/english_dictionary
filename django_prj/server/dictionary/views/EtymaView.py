from rest_framework import serializers, response, request, generics
from server import permissions
from dictionary.models import EtymaTable


class _EtymaSerializer(serializers.ModelSerializer):
    class Meta:
        model = EtymaTable
        fields = '__all__'


class CreateEtymaView(generics.CreateAPIView):
    serializer_class = _EtymaSerializer
    queryset = EtymaTable.objects.all()
    permission_classes = (permissions.IsRootUser,)


class UpdateEtymaView(generics.UpdateAPIView):
    serializer_class = _EtymaSerializer
    queryset = EtymaTable.objects.all()
    permission_classes = (permissions.IsRootUser,)
    lookup_field = 'e_name'


class RetrieveEtymaView(generics.RetrieveAPIView):
    serializer_class = _EtymaSerializer
    queryset = EtymaTable.objects.all()
    permission_classes = (permissions.AllowAny,)
    lookup_field = 'e_name'

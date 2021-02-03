from rest_framework import serializers, response, request, generics
from server import permissions
from dictionary.models import DistinguishWordTable


class DistinguishWordSerializer(serializers.ModelSerializer):
    class Meta:
        model = DistinguishWordTable
        fields = '__all__'


class CreateDistinguishWordView(generics.CreateAPIView):
    serializer_class = DistinguishWordSerializer
    queryset = DistinguishWordTable.objects.all()
    permission_classes = (permissions.IsRootUser,)


class UpdateDistinguishWordView(generics.UpdateAPIView):
    serializer_class = DistinguishWordSerializer
    queryset = DistinguishWordTable.objects.all()
    permission_classes = (permissions.IsRootUser,)


class RetrieveDistinguishWordView(generics.RetrieveAPIView):
    serializer_class = DistinguishWordSerializer
    queryset = DistinguishWordTable.objects.all()
    permission_classes = (permissions.AllowAny,)


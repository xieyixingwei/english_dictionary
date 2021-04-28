from rest_framework import serializers, response, request, generics, viewsets
from server import permissions
from server.views import ModelViewSetPermissionSerializerMap
from study.models import StudySentenceTable


class StudySentenceSerializer(serializers.ModelSerializer):
    class Meta:
        model = StudySentenceTable
        fields = '__all__'


class StudySentenceView(ModelViewSetPermissionSerializerMap):
    """
    句子学习 视图
    """
    queryset = StudySentenceTable.objects.all()
    serializer_class = StudySentenceSerializer
    permission_classes = (permissions.IsAuthenticated,)

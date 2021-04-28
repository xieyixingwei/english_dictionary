from rest_framework import serializers, response, request, generics, viewsets
from server import permissions
from server.views import ModelViewSetPermissionSerializerMap
from study.models import StudyWordTable


class StudyWordSerializer(serializers.ModelSerializer):
    class Meta:
        model = StudyWordTable
        fields = '__all__'


class StudyWordView(ModelViewSetPermissionSerializerMap):
    """
    学习计划 视图
    """
    queryset = StudyWordTable.objects.all()
    serializer_class = StudyWordSerializer
    permission_classes = (permissions.IsAuthenticated,)

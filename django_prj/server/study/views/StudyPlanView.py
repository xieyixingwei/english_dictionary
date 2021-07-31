from rest_framework import serializers, response, request, generics, viewsets
from server import permissions
from server.views import ModelViewSetPermissionSerializerMap
from study.models import StudyPlanTable


class StudyPlanSerializer(serializers.ModelSerializer):
    class Meta:
        model = StudyPlanTable
        fields = '__all__'


class StudyPlanView(ModelViewSetPermissionSerializerMap):
    """
    学习计划 视图
    """
    queryset = StudyPlanTable.objects.all()
    serializer_class = StudyPlanSerializer
    permission_classes = (permissions.IsAuthenticated,)

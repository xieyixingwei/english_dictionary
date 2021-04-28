from rest_framework import serializers, response, request, generics, viewsets
from server import permissions
from server.views import ModelViewSetPermissionSerializerMap
from study.models import StudyGrammerTable


class StudyGrammerSerializer(serializers.ModelSerializer):
    class Meta:
        model = StudyGrammerTable
        fields = '__all__'


class StudyGrammerView(ModelViewSetPermissionSerializerMap):
    """
    语法学习 视图
    """
    queryset = StudyGrammerTable.objects.all()
    serializer_class = StudyGrammerSerializer
    permission_classes = (permissions.IsAuthenticated,)

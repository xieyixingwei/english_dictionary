from rest_framework import serializers, response, request, generics, viewsets
from server import permissions
from server.views import ModelViewSetPermissionSerializerMap
from study.models import StudyGrammarTable


class StudyGrammarSerializer(serializers.ModelSerializer):
    class Meta:
        model = StudyGrammarTable
        fields = '__all__'


class StudyGrammarView(ModelViewSetPermissionSerializerMap):
    """
    语法学习 视图
    """
    queryset = StudyGrammarTable.objects.all()
    serializer_class = StudyGrammarSerializer
    permission_classes = (permissions.IsAuthenticated,)

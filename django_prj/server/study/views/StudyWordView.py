from enum import unique
from rest_framework import fields, serializers
from server import permissions
from server.views import ModelViewSetPermissionSerializerMap
from study.models import StudyWordTable
from dictionary.views.WordView import WordSerializer


class StudyWordSerializer(serializers.ModelSerializer):
    class Meta:
        model = StudyWordTable
        fields = '__all__'

    def to_representation(self, instance):
        response = super().to_representation(instance)
        response['word'] = WordSerializer(instance.word).data
        return response


class StudyWordView(ModelViewSetPermissionSerializerMap):
    """
    单词学习计划 视图
    """
    queryset = StudyWordTable.objects.all()
    serializer_class = StudyWordSerializer
    permission_classes = (permissions.IsAuthenticated,)

from enum import unique
from rest_framework import serializers
from rest_framework.pagination import PageNumberPagination
from django.db import models
import django_filters
from django_filters import filterset
from rest_framework import filters
from django_filters.rest_framework import DjangoFilterBackend

from server import permissions
from server.views import ModelViewSetPermissionSerializerMap
from study.models import StudyWordTable



class StudyWordSerializer(serializers.ModelSerializer):
    class Meta:
        model = StudyWordTable
        fields = '__all__'

    def to_representation(self, instance):
        response = super().to_representation(instance)
        response['word'] = self._word(instance.word)
        return response

    def _word(self, word):
        if word == None:
            return None
        from dictionary.views.WordView import WordSerializer
        if 'request' in self.context.keys() and 'study/word' in self.context['request'].path:
            # 防止 StudySentenceSerializer 和 SentenceSerializer 无限循环序列化
            return WordSerializer(word).data
        else:
            return None

# 分页自定义
class _StudyWordPagination(PageNumberPagination):
    page_size_query_param = 'page_size' # 表示url中每页数量参数
    page_query_param = 'page_index' # 表示url中的页码参数
    #page_size = 4 # 表示每页的默认显示数量
    #max_page_size = 5


class _StudyWordFilter(filterset.FilterSet):
    class Meta:
        model = StudyWordTable
        filter_overrides = {
            models.JSONField: {
                'filter_class': django_filters.CharFilter,
                'extra': lambda f: {
                    'lookup_expr': 'icontains',
                }
            }
        }
        fields = {
            'foreignUser': ['exact'],
            'word': ['exact'],
            'categories': ['icontains'],
            'familiarity': ['lte', 'gte'],
            'repeats': ['lte', 'gte'],
            'learnRecord': ['icontains'],
            'inplan': ['exact']
        }

class StudyWordView(ModelViewSetPermissionSerializerMap):
    """
    单词学习计划 视图
    """
    queryset = StudyWordTable.objects.all()
    serializer_class = StudyWordSerializer
    permission_classes = (permissions.IsAuthenticated,)
    pagination_class = _StudyWordPagination
    filter_class = _StudyWordFilter
    filter_backends = (filters.OrderingFilter, DjangoFilterBackend, )
    ordering_fields = ('id', 'familiarity', 'repeats')

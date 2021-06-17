from enum import unique
from rest_framework import serializers
from rest_framework.pagination import PageNumberPagination
from django.db import models
import django_filters
from django_filters import filterset

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


# 分页自定义
class _StudyWordPagination(PageNumberPagination):
    page_size_query_param = 'pageSize' # 表示url中每页数量参数
    page_query_param = 'pageIndex' # 表示url中的页码参数
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

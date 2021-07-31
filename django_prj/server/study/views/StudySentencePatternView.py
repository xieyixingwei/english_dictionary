from rest_framework import serializers
from django_filters import filterset
from django.db import models
import django_filters

from server import permissions
from server.views import ModelViewSetPermissionSerializerMap
from rest_framework.pagination import PageNumberPagination
from study.models.StudySentencePatternTable import StudySentencePatternTable
from server.serializer import CustomSerializer


class StudySentencePatternSerializer(CustomSerializer):
    class Meta:
        model = StudySentencePatternTable
        fields = '__all__'

    def nested(self):
        from dictionary.views.SentencePatternView import SentencePatternSerializer
        return {'sentencePattern': SentencePatternSerializer}

# 分页自定义
class _StudySentencePatternPagination(PageNumberPagination):
    page_size_query_param = 'page_size' # 表示url中每页数量参数
    page_query_param = 'page_index' # 表示url中的页码参数
    #page_size = 4 # 表示每页的默认显示数量
    #max_page_size = 5


class _StudySentencePatternFilter(filterset.FilterSet):
    class Meta:
        model = StudySentencePatternTable
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
            'sentencePattern': ['exact'],
            'categories': ['icontains'],
            'familiarity': ['lte', 'gte'],
            'inplan': ['exact']
        }

class StudySentencePatternView(ModelViewSetPermissionSerializerMap):
    """
    固定表达学习 视图
    """
    queryset = StudySentencePatternTable.objects.all()
    serializer_class = StudySentencePatternSerializer
    permission_classes = (permissions.IsAuthenticated,)
    pagination_class = _StudySentencePatternPagination
    filter_class = _StudySentencePatternFilter

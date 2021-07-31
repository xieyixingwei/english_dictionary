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
from server.serializer import CustomSerializer, CustomListSerializer


class StudyWordSerializer(CustomSerializer):
    class Meta:
        model = StudyWordTable
        fields = '__all__'
        list_serializer_class = CustomListSerializer

    def nested(self):
        from dictionary.views.WordView import WordSerializer
        return {'word': WordSerializer}

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

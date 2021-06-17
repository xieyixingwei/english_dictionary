from rest_framework import serializers
from django_filters import filterset
from django.db import models
import django_filters

from server import permissions
from server.views import ModelViewSetPermissionSerializerMap
from rest_framework.pagination import PageNumberPagination
from study.models import StudySentenceTable
from dictionary.views.SentenceView import SentenceSerializer


class StudySentenceSerializer(serializers.ModelSerializer):
    class Meta:
        model = StudySentenceTable
        fields = '__all__'

    def to_representation(self, instance):
        response = super().to_representation(instance)
        response['sentence'] = SentenceSerializer(instance.sentence).data
        return response


# 分页自定义
class _StudySentencePagination(PageNumberPagination):
    page_size_query_param = 'pageSize' # 表示url中每页数量参数
    page_query_param = 'pageIndex' # 表示url中的页码参数
    #page_size = 4 # 表示每页的默认显示数量
    #max_page_size = 5


class _StudySentenceFilter(filterset.FilterSet):
    class Meta:
        model = StudySentenceTable
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
            'sentence': ['exact'],
            'categories': ['icontains'],
            'familiarity': ['lte', 'gte'],
            'inplan': ['exact']
        }

class StudySentenceView(ModelViewSetPermissionSerializerMap):
    """
    句子学习 视图
    """
    queryset = StudySentenceTable.objects.all()
    serializer_class = StudySentenceSerializer
    permission_classes = (permissions.IsAuthenticated,)
    pagination_class = _StudySentencePagination
    filter_class = _StudySentenceFilter

from rest_framework import serializers
from rest_framework.pagination import PageNumberPagination
from django_filters import filterset
from django.db import models
import django_filters

from server import permissions
from dictionary.models.DistinguishTable import DistinguishTable
from server.views import ModelViewSetPermissionSerializerMap
from .SentenceView import SentenceSerializer
from dictionary.models.SentenceTable import SentenceTable
from drf_writable_nested import WritableNestedModelSerializer


class DistinguishSerializer(WritableNestedModelSerializer):
    sentencesForeign = SentenceSerializer(many=True)
    class Meta:
        model = DistinguishTable
        fields = '__all__'


# 分页自定义
class _DistinguishPagination(PageNumberPagination):
    page_size = 4 # 表示每页的默认显示数量
    page_size_query_param = 'page_size' # 表示url中每页数量参数
    page_query_param = 'page_index' # 表示url中的页码参数
    max_page_size = 100


class _DistinguishFilter(filterset.FilterSet):
    class Meta:
        model = DistinguishTable
        filter_overrides = {
            models.JSONField: {
                'filter_class': django_filters.CharFilter,
                'extra': lambda f: {
                    'lookup_expr': 'icontains',
                }
            }
        }
        fields = {
            'wordsForeign': ['icontains'],
            'content': ['icontains'],
        }


class DistinguishView(ModelViewSetPermissionSerializerMap):
    queryset = DistinguishTable.objects.all()
    serializer_class = DistinguishSerializer
    permission_classes = (permissions.IsRootUser,)
    permission_classes_map = {
        'retrieve': (permissions.AllowAny,),
    }
    pagination_class = _DistinguishPagination   # 自定义分页会覆盖settings全局配置的
    filter_class = _DistinguishFilter

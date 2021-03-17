from rest_framework import serializers, response, request, generics
from server import permissions
from dictionary.models import DistinguishWordTable
from server.views import ModelViewSetPermissionSerializerMap
from rest_framework.pagination import PageNumberPagination
from django_filters import filterset, fields
from rest_framework import filters
from django.db import models
import django_filters


class DistinguishWordSerializer(serializers.ModelSerializer):
    class Meta:
        model = DistinguishWordTable
        fields = '__all__'


# 分页自定义
class _DistinguishWordPagination(PageNumberPagination):
    page_size = 4 # 表示每页的默认显示数量
    page_size_query_param = 'page_size' # 表示url中每页数量参数
    page_query_param = 'page_index' # 表示url中的页码参数
    max_page_size = 100


class _DistinguishWordFilter(filterset.FilterSet):
    class Meta:
        model = DistinguishWordTable
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


class DistinguishWordView(ModelViewSetPermissionSerializerMap):
    queryset = DistinguishWordTable.objects.all()
    serializer_class = DistinguishWordSerializer
    permission_classes = (permissions.IsRootUser,)
    permission_classes_map = {
        'retrieve': (permissions.AllowAny,),
    }
    pagination_class = _DistinguishWordPagination   # 自定义分页会覆盖settings全局配置的
    filter_class = _DistinguishWordFilter

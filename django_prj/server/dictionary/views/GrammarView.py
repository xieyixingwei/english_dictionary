from rest_framework import serializers, response, request, generics
from server import permissions
from dictionary.models.GrammarTable import GrammarTable
from server.views import ModelViewSetPermissionSerializerMap
from rest_framework.pagination import PageNumberPagination
from django_filters import filterset, fields
from django.db import models
import django_filters


class GrammarSerializer(serializers.ModelSerializer):
    class Meta:
        model = GrammarTable
        fields = '__all__'


# 分页自定义
class _GrammarPagination(PageNumberPagination):
    page_size = 4 # 表示每页的默认显示数量
    page_size_query_param = 'page_size' # 表示url中每页数量参数
    page_query_param = 'page_index' # 表示url中的页码参数
    max_page_size = 100


class _GrammarFilter(filterset.FilterSet):
    class Meta:
        model = GrammarTable
        filter_overrides = {
            models.JSONField: {
                'filter_class': django_filters.CharFilter,
                'extra': lambda f: {
                    'lookup_expr': 'icontains',
                }
            }
        }
        fields = {
            'type': ['icontains'],
            'tag': ['icontains'],
            'content': ['icontains'],
        }


class GrammarView(ModelViewSetPermissionSerializerMap):
    queryset = GrammarTable.objects.all()
    serializer_class = GrammarSerializer
    permission_classes = (permissions.IsRootUser,)
    permission_classes_map = {
        'retrieve': (permissions.AllowAny,),
    }
    pagination_class = _GrammarPagination   # 自定义分页会覆盖settings全局配置的
    filter_class = _GrammarFilter


from dictionary.models.GrammarTable import GrammarTypeTable


class _GrammarTypeSerializer(serializers.ModelSerializer):
    class Meta:
        model = GrammarTypeTable
        fields = '__all__'


class GrammarTypeView(ModelViewSetPermissionSerializerMap):
    """
    语法的 Type 视图
    """
    queryset = GrammarTypeTable.objects.all()
    serializer_class = _GrammarTypeSerializer
    permission_classes = (permissions.IsRootUser,)
    permission_classes_map = {
        'list': (permissions.AllowAny,),
    }

from dictionary.models.GrammarTable import GrammarTagTable


class _GrammarTagSerializer(serializers.ModelSerializer):
    class Meta:
        model = GrammarTagTable
        fields = '__all__'


class GrammarTagView(ModelViewSetPermissionSerializerMap):
    """
    语法的 tags 视图
    """
    queryset = GrammarTagTable.objects.all()
    serializer_class = _GrammarTagSerializer
    permission_classes = (permissions.IsRootUser,)
    permission_classes_map = {
        'list': (permissions.AllowAny,),
    }

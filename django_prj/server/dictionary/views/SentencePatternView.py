from rest_framework import serializers
from rest_framework.pagination import PageNumberPagination
from django_filters import filterset
from django.db import models
import django_filters

from server import permissions
from server.views import ModelViewSetPermissionSerializerMap
from .ParaphraseView import ParaphraseSerializer
from dictionary.models.SentencePatternTable import SentencePatternTable


class SentencePatternSerializer(serializers.ModelSerializer):
    paraphraseSet = ParaphraseSerializer(many=True, read_only=True)
    class Meta:
        model = SentencePatternTable
        fields = '__all__'


class _SentencePatternRetrieveSerializer(serializers.ModelSerializer):
    paraphraseSet = ParaphraseSerializer(many=True, read_only=True)
    class Meta:
        model = SentencePatternTable
        fields = '__all__'


# 分页自定义
class _SentencePatternPagination(PageNumberPagination):
    page_size = 4 # 表示每页的默认显示数量
    page_size_query_param = 'page_size' # 表示url中每页数量参数
    page_query_param = 'page_index' # 表示url中的页码参数
    max_page_size = 100


class _SentencePatternFilter(filterset.FilterSet):
    class Meta:
        model = SentencePatternTable
        filter_overrides = {
            models.JSONField: {
                'filter_class': django_filters.CharFilter,
                'extra': lambda f: {
                    'lookup_expr': 'icontains',
                }
            }
        }
        fields = {
            'content': ['exact','icontains'],
        }


class SentencePatternView(ModelViewSetPermissionSerializerMap):
    """
    常用句型 视图
    """
    queryset = SentencePatternTable.objects.all()
    serializer_class = SentencePatternSerializer
    serializer_class_map = {
        'retrieve': _SentencePatternRetrieveSerializer,
        'list': _SentencePatternRetrieveSerializer,
    }
    permission_classes = (permissions.IsRootUser,)
    permission_classes_map = {
        'retrieve': (permissions.AllowAny,),
    }
    pagination_class = _SentencePatternPagination
    filter_class = _SentencePatternFilter

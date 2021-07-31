from rest_framework import serializers
from rest_framework.pagination import PageNumberPagination
from django_filters import filterset
from django.db import models
import django_filters

from server import permissions
from server.views import ModelViewSetPermissionSerializerMap
from dictionary.models.DialogTable import DialogTable, DialogTagTable
from .SentenceView import SentenceSerializer



class _DialogSerializer(serializers.ModelSerializer):
    sentenceSet = SentenceSerializer(many=True, read_only=True)
    class Meta:
        model = DialogTable
        fields = '__all__'


# 分页自定义
class _DialogPagination(PageNumberPagination):
    page_size = 4 # 表示每页的默认显示数量
    page_size_query_param = 'page_size' # 表示url中每页数量参数
    page_query_param = 'page_index' # 表示url中的页码参数
    max_page_size = 100


class _DialogFilter(filterset.FilterSet):
    class Meta:
        model = DialogTable
        filter_overrides = {
            models.JSONField: {
                'filter_class': django_filters.CharFilter,
                'extra': lambda f: {
                    'lookup_expr': 'icontains',
                }
            }
        }
        fields = {
            'tag': ['icontains'],
            'title': ['icontains'],
        }


class DialogView(ModelViewSetPermissionSerializerMap):
    """
    对话 视图
    """
    queryset = DialogTable.objects.all()
    serializer_class = _DialogSerializer
    permission_classes = (permissions.IsRootUser,)
    permission_classes_map = {
        'retrieve': (permissions.AllowAny,),
    }
    pagination_class = _DialogPagination
    filter_class = _DialogFilter


class _DialogTagSerializer(serializers.ModelSerializer):
    class Meta:
        model = DialogTagTable
        fields = '__all__'


class DialogTagView(ModelViewSetPermissionSerializerMap):
    """
    对话 tags 视图
    """
    queryset = DialogTagTable.objects.all()
    serializer_class = _DialogTagSerializer
    permission_classes = (permissions.IsRootUser,)
    permission_classes_map = {
        'list': (permissions.AllowAny,),
    }

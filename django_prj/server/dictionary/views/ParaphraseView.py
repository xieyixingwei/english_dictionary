from rest_framework import serializers
from rest_framework.pagination import PageNumberPagination
from django_filters import filterset
from django.db import models
import django_filters

from server import permissions
from server.views import ModelViewSetPermissionSerializerMap
from .SentenceView import SentenceSerializer
from dictionary.models.ParaphraseTable import ParaphraseTable
from server.serializer import CustomSerializer, CustomListSerializer


class ParaphraseSerializer(CustomSerializer):
    sentenceSet = SentenceSerializer(many=True, read_only=True)
    class Meta:
        model = ParaphraseTable
        fields = '__all__'
        list_serializer_class = CustomListSerializer

    def nested(self):
        return {'sentenceSet': SentenceSerializer}

# 分页自定义
class _ParaphrasePagination(PageNumberPagination):
    page_size = 4 # 表示每页的默认显示数量
    page_size_query_param = 'page_size' # 表示url中每页数量参数
    page_query_param = 'page_index' # 表示url中的页码参数
    max_page_size = 100


class _ParaphraseFilter(filterset.FilterSet):
    class Meta:
        model = ParaphraseTable
        filter_overrides = {
            models.JSONField: {
                'filter_class': django_filters.CharFilter,
                'extra': lambda f: {
                    'lookup_expr': 'icontains',
                }
            }
        }
        fields = {
            'interpret': ['icontains'],
            'partOfSpeech': ['exact'],
        }


class ParaphraseView(ModelViewSetPermissionSerializerMap):
    """
    释义 视图
    """
    queryset = ParaphraseTable.objects.all()
    serializer_class = ParaphraseSerializer
    permission_classes = (permissions.IsRootUser,)
    permission_classes_map = {
        'retrieve': (permissions.AllowAny,),
    }
    pagination_class = _ParaphrasePagination
    filter_class = _ParaphraseFilter

from rest_framework import serializers
from rest_framework.pagination import PageNumberPagination
from django_filters import filterset
from django.db import models
import django_filters

from server import permissions
from dictionary.models.DistinguishTable import DistinguishTable
from server.views import ModelViewSetPermissionSerializerMap
from dictionary.views.SentencePatternView import SentencePatternSerializer
from dictionary.models.SentencePatternTable import SentencePatternTable


class DistinguishSerializer(serializers.ModelSerializer):
    class Meta:
        model = DistinguishTable
        fields = '__all__'
        # foreigns = ('sentencePatternForeign')

    def to_internal_value(self, data):
        if isinstance(data, dict):
            sentencePatternForeign = data.pop('sentencePatternForeign')
            data['sentencePatternForeign'] = [n['id'] for n in sentencePatternForeign]
        ret = super().to_internal_value(data)
        return ret

    def to_representation(self, instance):
        response = super().to_representation(instance)
        sentencePatternForeign = response.pop('sentencePatternForeign')
        response['sentencePatternForeign'] = [SentencePatternSerializer(SentencePatternTable.objects.get(pk=pk)).data for pk in sentencePatternForeign]
        return response


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

from rest_framework import serializers
from rest_framework.pagination import PageNumberPagination
from django_filters import filterset
from django.db import models
import django_filters

from server import permissions
from server.views import ModelViewSetPermissionSerializerMap
from dictionary.models.WordTable import WordTable
from .GrammarView import GrammarSerializer
from .DistinguishView import DistinguishSerializer
from .ParaphraseView import ParaphraseSerializer
from .SentencePatternView import SentencePatternSerializer


class _WordSerializer(serializers.ModelSerializer):
    paraphraseSet = ParaphraseSerializer(many=True, read_only=True)
    sentencePatternSet = SentencePatternSerializer(many=True, read_only=True)
    grammarSet = GrammarSerializer(many=True, read_only=True)
    distinguishSet = DistinguishSerializer(many=True, read_only=True)
    class Meta:
        model = WordTable
        fields = '__all__'


# 分页自定义
class _WordPagination(PageNumberPagination):
    page_size = 4 # 表示每页的默认显示数量
    page_size_query_param = 'page_size' # 表示url中每页数量参数
    page_query_param = 'page_index' # 表示url中的页码参数
    max_page_size = 100


class _WordFilter(filterset.FilterSet):
    class Meta:
        model = WordTable
        filter_overrides = {
            models.JSONField: {
                'filter_class': django_filters.CharFilter,
                'extra': lambda f: {
                    'lookup_expr': 'icontains',
                }
            }
        }
        fields = {
            'name': ['exact','icontains'],
            'tag': ['icontains'],
            'etyma': ['icontains'],
        }


class WordView(ModelViewSetPermissionSerializerMap):
    """
    单词 视图
    """
    queryset = WordTable.objects.all()
    serializer_class = _WordSerializer
    permission_classes = (permissions.IsRootUser,)
    permission_classes_map = {
        'retrieve': (permissions.AllowAny,),
    }
    lookup_field = 'name'
    # django-filter:
    #   1. pip3 intall django-filter
    #   2. INSTALLED_APPS = [ 'django_filters', ]
    #   3. REST_FRAMEWORK = {
    #          'DEFAULT_FILTER_BACKENDS': (
    #              'django_filters.rest_framework.DjangoFilterBackend',
    #          ),
    #      }
    #   4. 在视图里定义 filter_fields 或者 filter_class 和 search_fields = ('title',)
    #   5. 使用 path/?filter_fields=value1
    #      多个条件可以使用 & 连接
    pagination_class = _WordPagination   # 自定义分页会覆盖settings全局配置的
    # filter_backends 指定过滤器的类型: (DjangoFilterBackend)过滤,(SearchFilter)搜索,(OrderingFilter)排序
    # filter_backends = (django_filters.rest_framework.DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter, )
    filter_class = _WordFilter

from rest_framework import serializers, response, request, generics, viewsets
from server import permissions
from server.views import ModelViewSetPermissionSerializerMap
from dictionary.models import WordTable
from .WordToSentenceView import WordToSentenceSerializer
from .GrammarView import GrammarSerializer
from .DistinguishWordView import DistinguishWordSerializer
from rest_framework.pagination import PageNumberPagination
from django_filters import filterset, fields
from rest_framework import filters
from django.db import models
import django_filters


class _WordSerializer(serializers.ModelSerializer):
    class Meta:
        model = WordTable
        fields = '__all__'


class _WordUpdateSerializer(serializers.ModelSerializer):
    class Meta:
        model = WordTable
        exclude = ('w_name',)


class _WordRetrieveSerializer(serializers.ModelSerializer):
    sentences = WordToSentenceSerializer(many=True, read_only=True)
    word_grammar = GrammarSerializer(many=True, read_only=True)
    distinguish = DistinguishWordSerializer(many=True, read_only=True)
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
            'w_name': ['exact','icontains'],
            'w_tags': ['icontains'],
            'w_etyma': ['icontains'],
            'w_partofspeech': ['icontains'],
        }


class WordView(ModelViewSetPermissionSerializerMap):
    """
    单词 视图
    """
    queryset = WordTable.objects.all()
    serializer_class = _WordSerializer
    serializer_class_map = {
        'update': _WordUpdateSerializer,
        'retrieve': _WordRetrieveSerializer,
        'list': _WordRetrieveSerializer,
    }
    permission_classes = (permissions.IsRootUser,)
    permission_classes_map = {
        'retrieve': (permissions.AllowAny,),
    }
    lookup_field = 'w_name'
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



from dictionary.models import EtymaTable


class _EtymaSerializer(serializers.ModelSerializer):
    class Meta:
        model = EtymaTable
        fields = '__all__'


class EtymaView(ModelViewSetPermissionSerializerMap):
    """
    词根 视图
    """
    queryset = EtymaTable.objects.all()
    serializer_class = _EtymaSerializer
    permission_classes = (permissions.IsRootUser,)
    permission_classes_map = {
        'retrieve': (permissions.AllowAny,),
    }


from dictionary.models import WordTagsTable


class _WordTagsSerializer(serializers.ModelSerializer):
    class Meta:
        model = WordTagsTable
        fields = '__all__'


class WordTagsView(ModelViewSetPermissionSerializerMap):
    """
    单词 tags 视图
    """
    queryset = WordTagsTable.objects.all()
    serializer_class = _WordTagsSerializer
    permission_classes = (permissions.IsRootUser,)
    permission_classes_map = {
        'list': (permissions.AllowAny,),
    }

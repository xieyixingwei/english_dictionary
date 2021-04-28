from rest_framework import serializers, response, request, generics, viewsets
from server import permissions
from server.views import ModelViewSetPermissionSerializerMap
from dictionary.models import WordTable
from .GrammarView import GrammarSerializer
from .DistinguishWordView import DistinguishWordSerializer
from .SentenceView import SentenceSerializer
from rest_framework.pagination import PageNumberPagination
from django_filters import filterset, fields
from rest_framework import filters
from django.db import models
import django_filters
from dictionary.models import SentencePatternTable
from dictionary.models import ParaphraseTable
from rest_framework.decorators import action


class _ParaphraseSerializer(serializers.ModelSerializer):
    sentenceSet = SentenceSerializer(many=True, read_only=True)
    class Meta:
        model = ParaphraseTable
        fields = '__all__'


class _SentencePatternSerializer(serializers.ModelSerializer):
    paraphraseSet = _ParaphraseSerializer(many=True, read_only=True)
    class Meta:
        model = SentencePatternTable
        fields = '__all__'

class _WordSerializer(serializers.ModelSerializer):
    class Meta:
        model = WordTable
        fields = '__all__'


class _WordUpdateSerializer(serializers.ModelSerializer):
    class Meta:
        model = WordTable
        exclude = ('name',)


class _WordRetrieveSerializer(serializers.ModelSerializer):
    paraphraseSet = _ParaphraseSerializer(many=True, read_only=True)
    sentencePatternSet = _SentencePatternSerializer(many=True, read_only=True)
    grammarSet = GrammarSerializer(many=True, read_only=True)
    distinguishSet = DistinguishWordSerializer(many=True, read_only=True)
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
    serializer_class_map = {
        'update': _WordUpdateSerializer,
        'retrieve': _WordRetrieveSerializer,
        'list': _WordRetrieveSerializer,
    }
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


from dictionary.models import EtymaTable


class _EtymaSerializer(serializers.ModelSerializer):
    class Meta:
        model = EtymaTable
        fields = '__all__'


# 分页自定义
class _EtymaPagination(PageNumberPagination):
    page_size = 4 # 表示每页的默认显示数量
    page_size_query_param = 'page_size' # 表示url中每页数量参数
    page_query_param = 'page_index' # 表示url中的页码参数
    max_page_size = 100


class _EtymaFilter(filterset.FilterSet):
    class Meta:
        model = EtymaTable
        fields = {
            'name': ['exact','icontains'],
            'type': ['exact'],
        }


class EtymaView(ModelViewSetPermissionSerializerMap):
    """
    词根 视图
    """
    queryset = EtymaTable.objects.all()
    serializer_class = _EtymaSerializer
    permission_classes = (permissions.IsRootUser,)
    permission_classes_map = {
        'retrieve': (permissions.AllowAny,),
        'list': (permissions.AllowAny,),
    }
    #lookup_field = 'name'
    pagination_class = _EtymaPagination   # 自定义分页会覆盖settings全局配置的
    filter_class = _EtymaFilter


from dictionary.models import WordTagTable


class _WordTagSerializer(serializers.ModelSerializer):
    class Meta:
        model = WordTagTable
        fields = '__all__'


class WordTagView(ModelViewSetPermissionSerializerMap):
    """
    单词 tags 视图
    """
    queryset = WordTagTable.objects.all()
    serializer_class = _WordTagSerializer
    permission_classes = (permissions.IsRootUser,)
    permission_classes_map = {
        'list': (permissions.AllowAny,),
    }


class _SentencePatternRetrieveSerializer(serializers.ModelSerializer):
    paraphraseSet = _ParaphraseSerializer(many=True, read_only=True)
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
    serializer_class = _SentencePatternSerializer
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


class _ParaphraseRetrieveSerializer(serializers.ModelSerializer):
    sentenceSet = SentenceSerializer(many=True, read_only=True)
    class Meta:
        model = ParaphraseTable
        fields = '__all__'


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
    serializer_class = _ParaphraseSerializer
    serializer_class_map = {
        'retrieve': _ParaphraseRetrieveSerializer,
        'list': _ParaphraseRetrieveSerializer,
    }
    permission_classes = (permissions.IsRootUser,)
    permission_classes_map = {
        'retrieve': (permissions.AllowAny,),
    }
    pagination_class = _ParaphrasePagination
    filter_class = _ParaphraseFilter

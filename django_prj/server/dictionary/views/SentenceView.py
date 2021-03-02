from rest_framework import serializers, response, request, generics
from server import permissions
from dictionary.models import SentenceTable
from .GrammarView import GrammarSerializer
from server.views import ModelViewSetPermissionSerializerMap
from rest_framework.pagination import PageNumberPagination
from django_filters import filterset, fields
from rest_framework import filters
from django.db import models
import django_filters


class SentenceSerializer(serializers.ModelSerializer):
    class Meta:
        model = SentenceTable
        fields = '__all__'


class _RetrieveSentenceSerializer(serializers.ModelSerializer):
    sentence_grammar = GrammarSerializer(many=True, read_only=True)
    class Meta:
        model = SentenceTable
        fields = ('__all__')


# 分页自定义
class _SentencePagination(PageNumberPagination):
    page_size = 4 # 表示每页的默认显示数量
    page_size_query_param = 'page_size' # 表示url中每页数量参数
    page_query_param = 'page_index' # 表示url中的页码参数
    max_page_size = 100

class _SentenceFilter(filterset.FilterSet):
    class Meta:
        model = SentenceTable
        filter_overrides = {
            models.JSONField: {
                'filter_class': django_filters.CharFilter,
                #'extra': lambda f: {
                #    'lookup_expr': 'icontains',
                #}
            }
        }
        fields = {
            's_en': ['icontains'],
            's_ch': ['icontains'],
            's_type': ['exact'],
            's_tags': ['icontains'],
            's_tense': ['icontains'],
            's_form': ['icontains']
        }


class SentenceView(ModelViewSetPermissionSerializerMap):
    """
    句子 视图
    """
    queryset = SentenceTable.objects.all()
    serializer_class = SentenceSerializer
    serializer_class_map = {
        'retrieve': _RetrieveSentenceSerializer,
        'list': _RetrieveSentenceSerializer,
    }
    permission_classes = (permissions.IsRootUser,)
    permission_classes_map = {
        'retrieve': (permissions.AllowAny,),
    }
    pagination_class = _SentencePagination   # 自定义分页会覆盖settings全局配置的
    # filter_backends 指定过滤器的类型: (DjangoFilterBackend)过滤,(SearchFilter)搜索,(OrderingFilter)排序
    # filter_backends = (django_filters.rest_framework.DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter, )
    filter_class = _SentenceFilter


from dictionary.models import SentenceTagsTable


class _SentenceTagSerializer(serializers.ModelSerializer):
    class Meta:
        model = SentenceTagsTable
        fields = '__all__'


class SentenceTagsView(ModelViewSetPermissionSerializerMap):
    """
    句子 tags 视图
    """
    queryset = SentenceTagsTable.objects.all()
    serializer_class = _SentenceTagSerializer
    permission_classes = (permissions.IsRootUser,)
    permission_classes_map = {
        'list': (permissions.AllowAny,),
    }


from dictionary.models import SentenceTagsTable


class _SentenceTagSerializer(serializers.ModelSerializer):
    class Meta:
        model = SentenceTagsTable
        fields = '__all__'


class SentenceTagsView(ModelViewSetPermissionSerializerMap):
    """
    句子 tags 视图
    """
    queryset = SentenceTagsTable.objects.all()
    serializer_class = _SentenceTagSerializer
    permission_classes = (permissions.IsRootUser,)
    permission_classes_map = {
        'list': (permissions.AllowAny,),
    }


from dictionary.models import RelativeSentenceTable


class _RelativeSentenceSerializer(serializers.ModelSerializer):
    class Meta:
        model = RelativeSentenceTable
        fields = '__all__'


class RelativeSentenceView(ModelViewSetPermissionSerializerMap):
    """
    近义句/反义句 视图
    """
    queryset = RelativeSentenceTable.objects.all()
    serializer_class = _RelativeSentenceSerializer
    permission_classes = (permissions.IsRootUser,)
    permission_classes_map = {
        'retrieve': (permissions.AllowAny,),
    }
    filter_fields = ('r_sentence_a','r_sentence_b', 'r_type')

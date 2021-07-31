# -*- coding:utf-8 -*- 
from rest_framework import serializers
from rest_framework.pagination import PageNumberPagination
from django_filters import filterset
from django.db import models
import django_filters
from django.core.cache import cache


from .GrammarView import GrammarSerializer
from server import permissions
from dictionary.models.SentenceTable import SentenceTable
from .GrammarView import GrammarSerializer
from server.views import ModelViewSetPermissionSerializerMap
from server.serializer import CustomSerializer, CustomListSerializer
from django.core.cache import cache
from dictionary.views.GrammarView import GrammarSerializer
from study.views.StudySentenceView import StudySentenceSerializer



class SentenceSerializer(CustomSerializer):
    grammarSet = GrammarSerializer(many=True, read_only=True)
    #studySentenceSet = serializers.SerializerMethodField()
    studySentenceSet = StudySentenceSerializer(many=True, read_only=True)

    class Meta:
        model = SentenceTable
        fields = '__all__'
        list_serializer_class = CustomListSerializer

    def nested(self):
        return {'synonym': SentenceSerializer, 'antonym': SentenceSerializer, 'studySentenceSet': StudySentenceSerializer}

    def filter(self):
        return {'studySentenceSet': self.filter_SentenceSet}

    def filter_SentenceSet(self, objs):
        if not 'request' in self.context.keys():
            return objs
        request = self.context['request']
        token = request.query_params.get('token')
        if not token:
            token = request.headers.get('authorization') 
        try:
            userId = cache.get(token)
            return [ss for ss in objs if userId == ss['foreignUser']]
        except:
            return []

'''
    def to_representation(self, instance):
        response = super().to_representation(instance)
        response['studySentenceSet'] = self._studySentenceSet(response.pop('studySentenceSet'))
        return response
'''


#-------------------
'''
    def get_studySentenceSet(self, obj):
        if not 'request' in self.context.keys():
            # 防止 StudySentenceSerializer 和 SentenceSerializer 无限循环序列化
            return []
        request = self.context['request']
        token = request.query_params.get('token')
        if not token:
            token = request.headers.get('authorization') 
        try:
            userId = cache.get(token)
            return [{'id': ss.id, 'foreignUser': ss.foreignUser.id, 'inplan': ss.inplan, 'categories': ss.categories}
                        for ss in obj.studySentenceSet.all()
                        if userId == ss.foreignUser.id]
        except:
            return []
'''

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
                'extra': lambda f: {
                    'lookup_expr': 'icontains',
                }
            }
        }
        fields = {
            'en': ['icontains'],
            'cn': ['icontains'],
            'type': ['exact'],
            'tag': ['icontains'],
            'tense': ['exact'],
            'pattern': ['icontains']
        }


class SentenceView(ModelViewSetPermissionSerializerMap):
    """
    句子 视图
    """
    queryset = SentenceTable.objects.all()
    serializer_class = SentenceSerializer
    permission_classes = (permissions.IsRootUser,)
    permission_classes_map = {
        'retrieve': (permissions.AllowAny,),
    }
    pagination_class = _SentencePagination   # 自定义分页会覆盖settings全局配置的
    # filter_backends 指定过滤器的类型: (DjangoFilterBackend)过滤,(SearchFilter)搜索,(OrderingFilter)排序
    # filter_backends = (django_filters.rest_framework.DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter, )
    filter_class = _SentenceFilter


from dictionary.models.SentenceTable import SentenceTagTable


class _SentenceTagSerializer(serializers.ModelSerializer):
    class Meta:
        model = SentenceTagTable
        fields = '__all__'


class SentenceTagView(ModelViewSetPermissionSerializerMap):
    """
    句子 tags 视图
    """
    queryset = SentenceTagTable.objects.all()
    serializer_class = _SentenceTagSerializer
    permission_classes = (permissions.IsRootUser,)
    permission_classes_map = {
        'list': (permissions.AllowAny,),
    }

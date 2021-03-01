from rest_framework import serializers, response, request, generics, viewsets
from server import permissions
from server.views import ModelViewSetPermissionSerializerMap
from dictionary.models import WordTable
from .WordToSentenceView import WordToSentenceSerializer
from .GrammarView import GrammarSerializer
from .DistinguishWordView import DistinguishWordSerializer
from rest_framework import filters
from dictionary.models import RelativeWordTable


class _RelativeWordSerializer(serializers.ModelSerializer):
    class Meta:
        model = RelativeWordTable
        fields = '__all__'


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


class WordView(ModelViewSetPermissionSerializerMap):
    """
    单词 视图
    """
    queryset = WordTable.objects.all()
    serializer_class = _WordSerializer
    serializer_class_map = {
        'update': _WordUpdateSerializer,
        'retrieve': _WordRetrieveSerializer
    }
    permission_classes = (permissions.IsRootUser,)
    permission_classes_map = {
        'retrieve': (permissions.AllowAny,),
    }
    lookup_field = 'w_name'


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


class RelativeWordView(ModelViewSetPermissionSerializerMap):
    """
    近义词/反义词 视图
    """
    queryset = RelativeWordTable.objects.all()
    serializer_class = _RelativeWordSerializer
    permission_classes = (permissions.IsRootUser,)
    permission_classes_map = {
        'list': (permissions.AllowAny,),
    }
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
    filter_fields = ('r_word_a','r_word_b', 'r_type')

    #lookup_field = 'r_word_a'

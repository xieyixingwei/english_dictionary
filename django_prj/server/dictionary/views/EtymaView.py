from rest_framework import serializers
from rest_framework.pagination import PageNumberPagination
from django_filters import filterset

from server import permissions
from server.views import ModelViewSetPermissionSerializerMap
from dictionary.models.EtymaTable import EtymaTable


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

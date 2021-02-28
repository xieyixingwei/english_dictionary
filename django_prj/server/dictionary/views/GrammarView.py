from rest_framework import serializers, response, request, generics
from server import permissions
from dictionary.models import GrammarTable
from server.views import ModelViewSetPermissionSerializerMap


class GrammarSerializer(serializers.ModelSerializer):
    class Meta:
        model = GrammarTable
        fields = '__all__'


class GrammarView(ModelViewSetPermissionSerializerMap):
    queryset = GrammarTable.objects.all()
    serializer_class = GrammarSerializer
    permission_classes = (permissions.IsRootUser,)
    permission_classes_map = {
        'retrieve': (permissions.AllowAny,),
    }


from dictionary.models import GrammarTypeTable


class _GrammarTypeSerializer(serializers.ModelSerializer):
    class Meta:
        model = GrammarTypeTable
        fields = '__all__'


class GrammarTypeView(ModelViewSetPermissionSerializerMap):
    """
    语法的 type 视图
    """
    queryset = GrammarTypeTable.objects.all()
    serializer_class = _GrammarTypeSerializer
    permission_classes = (permissions.IsRootUser,)
    permission_classes_map = {
        'list': (permissions.AllowAny,),
    }

from dictionary.models import GrammarTagTable


class _GrammarTagSerializer(serializers.ModelSerializer):
    class Meta:
        model = GrammarTagTable
        fields = '__all__'


class GrammarTagView(ModelViewSetPermissionSerializerMap):
    """
    语法的 tags 视图
    """
    queryset = GrammarTagTable.objects.all()
    serializer_class = _GrammarTagSerializer
    permission_classes = (permissions.IsRootUser,)
    permission_classes_map = {
        'list': (permissions.AllowAny,),
    }

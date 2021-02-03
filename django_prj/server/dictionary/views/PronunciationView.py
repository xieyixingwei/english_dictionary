from rest_framework import serializers, response, request, generics
from server import permissions
from dictionary.models import SoundmarkTable, PronunciationTable



class _SoundmarkSerializer(serializers.ModelSerializer):
    class Meta:
        model = SoundmarkTable
        fields = '__all__'


class CreateSoundmarkView(generics.CreateAPIView):
    serializer_class = _SoundmarkSerializer
    queryset = SoundmarkTable.objects.all()
    permission_classes = (permissions.IsRootUser,)


class UpdateSoundmarkView(generics.UpdateAPIView):
    serializer_class = _SoundmarkSerializer
    queryset = SoundmarkTable.objects.all()
    permission_classes = (permissions.IsRootUser,)
    lookup_field = 's_name'

class RetrieveSoundmarkView(generics.RetrieveAPIView):
    serializer_class = _SoundmarkSerializer
    queryset = SoundmarkTable.objects.all()
    permission_classes = (permissions.AllowAny,)
    lookup_field = 's_name'

'''
class _PronunciationSerializer(serializers.ModelSerializer):
    class Meta:
        model = PronunciationTable
        fields = '__all__'


class CreatePronunciationView(generics.CreateAPIView):
    serializer_class = _PronunciationSerializer
    queryset = PronunciationTable.objects.all()
    permission_classes = (permissions.IsRootUser,)


class UpdatePronunciationView(generics.UpdateAPIView):
    serializer_class = _PronunciationSerializer
    queryset = PronunciationTable.objects.all()
    permission_classes = (permissions.IsRootUser,)


class RetrievePronunciationView(generics.RetrieveAPIView):
    serializer_class = _PronunciationSerializer
    queryset = PronunciationTable.objects.all()
    permission_classes = (permissions.AllowAny,)
'''

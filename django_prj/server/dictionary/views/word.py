from django.shortcuts import render
from django.views import View
from django.http import HttpRequest, HttpResponse, JsonResponse
from rest_framework import serializers
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.request import Request

from dictionary.models import Word


class WordSerializer(serializers.ModelSerializer):

    class Meta:
        model = Word
        fields = ('w_name', 'w_voice_us', 'w_voice_uk', 'w_morph'
                  'w_tags', 'w_etyma', 'w_synonym', 'w_antonym',
                  'w_origin', 'w_shorthand', 'w_partofspeech', 'w_sentence_pattern',
                  'w_word_collocation', 'w_image', 'w_vedio')


class WordView(View):
    def get(self, request:HttpRequest):
        return JsonResponse(data={'status': 'get ok'})

    def post(self, request:HttpRequest):
        return JsonResponse(data={'status': 'post ok'})

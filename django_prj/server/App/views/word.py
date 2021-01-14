from django.shortcuts import render
from django.views import View
from django.http import HttpRequest, HttpResponse

from App.models import Word


class WordView(View):
    
    def get(self, request:HttpRequest):
        w_name = request.GET.get("w_name")
        try:
            word = Word.objects.get(w_name=w_name)
        except Exception as e:
            return HttpResponse(e)
        return 

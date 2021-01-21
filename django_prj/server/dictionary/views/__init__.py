from django.shortcuts import render
from django.http import HttpResponse

from .word import WordView


def index(request):
    return render(request, 'index.html')

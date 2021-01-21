from django.conf.urls import url
from django.urls import path

from . import views

urlpatterns = [
    url(r'^words/$', views.WordView.as_view(), name='words'),
]
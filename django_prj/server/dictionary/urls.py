from django.conf.urls import url
from django.urls import path

from . import views

urlpatterns = [
    url(r'^word/create/$', views.WordView.as_view({'post': 'create'})),
    url(r'^word/update/(?P<w_name>\w+)/$', views.WordView.as_view({'put': 'update'})),
    url(r'^word/delete/(?P<w_name>\w+)/$', views.WordView.as_view({'delete': 'destroy'})),
    url(r'^word/(?P<w_name>\w+)/$', views.WordView.as_view({'get': 'retrieve'})),
    url(r'^word/$', views.WordView.as_view({'get': 'list'})),

    url(r'^wordtags/create/$', views.WordTagsView.as_view({'post': 'create'})),
    url(r'^wordtags/delete/(?P<pk>\w+)/$', views.WordTagsView.as_view({'delete': 'destroy'})),
    url(r'^wordtags/$', views.WordTagsView.as_view({'get': 'list'})),

    url(r'^sentence/create/$', views.SentenceView.as_view({'post': 'create'})),
    url(r'^sentence/update/(?P<pk>\d+)/$', views.SentenceView.as_view({'put': 'update'})),
    url(r'^sentence/delete/(?P<pk>\w+)/$', views.SentenceView.as_view({'delete': 'destroy'})),
    url(r'^sentence/(?P<pk>\d+)/$', views.SentenceView.as_view({'get': 'retrieve'})),
    url(r'^sentence/$', views.SentenceView.as_view({'get': 'list'})),

    url(r'^sentencetags/create/$', views.SentenceTagsView.as_view({'post': 'create'})),
    url(r'^sentencetags/delete/(?P<pk>\w+)/$', views.SentenceTagsView.as_view({'delete': 'destroy'})),
    url(r'^sentencetags/$', views.SentenceTagsView.as_view({'get': 'list'})),

    url(r'^grammar/create/$', views.GrammarView.as_view({'post': 'create'})),
    url(r'^grammar/update/(?P<pk>\d+)/$', views.GrammarView.as_view({'put': 'update'})),
    url(r'^grammar/delete/(?P<pk>\d+)/$', views.GrammarView.as_view({'delete': 'destroy'})),
    url(r'^grammar/(?P<pk>\d+)/$', views.GrammarView.as_view({'get': 'retrieve'})),
    url(r'^grammar/$', views.GrammarView.as_view({'get': 'list'})),

    url(r'^grammartype/create/$', views.GrammarTypeView.as_view({'post': 'create'})),
    url(r'^grammartype/delete/(?P<pk>\w+)/$', views.GrammarTypeView.as_view({'delete': 'destroy'})),
    url(r'^grammartype/$', views.GrammarTypeView.as_view({'get': 'list'})),

    url(r'^grammartags/create/$', views.GrammarTagView.as_view({'post': 'create'})),
    url(r'^grammartags/delete/(?P<pk>\w+)/$', views.GrammarTagView.as_view({'delete': 'destroy'})),
    url(r'^grammartags/$', views.GrammarTagView.as_view({'get': 'list'})),

    url(r'^distinguish_word/create/$', views.DistinguishWordView.as_view({'post': 'create'})),
    url(r'^distinguish_word/update/(?P<pk>\d+)/$', views.DistinguishWordView.as_view({'put': 'update'})),
    url(r'^distinguish_word/delete/(?P<pk>\d+)/$', views.DistinguishWordView.as_view({'delete': 'destroy'})),
    url(r'^distinguish_word/(?P<pk>\d+)/$', views.DistinguishWordView.as_view({'get': 'retrieve'})),

    url(r'^word_to_sentence/create/$', views.WordToSentenceView.as_view({'post': 'create'})),
    url(r'^word_to_sentence/update/(?P<wtg_word>\w+)/$', views.WordToSentenceView.as_view({'put': 'update'})),
    url(r'^word_to_sentence/(?P<wtg_word>\w+)/$', views.WordToSentenceView.as_view({'delete': 'destroy'})),
    url(r'^word_to_sentence/$', views.WordToSentenceView.as_view({'get': 'list'})),

    url(r'^etyma/create/$', views.EtymaView.as_view({'post': 'create'})),
    url(r'^etyma/delete/(?P<e_name>\w+)/$', views.EtymaView.as_view({'delete': 'destroy'})),
    url(r'^etyma/update/(?P<e_name>\w+)/$', views.EtymaView.as_view({'put': 'update'})),
    url(r'^etyma/(?P<e_name>\w+)/$', views.EtymaView.as_view({'get': 'retrieve'})),
    url(r'^etyma/$', views.EtymaView.as_view({'get': 'list'})),

    url(r'^soundmark/create/$', views.SoundmarkView.as_view({'post': 'create'})),
    url(r'^soundmark/update/(?P<s_name>\w+)/$', views.SoundmarkView.as_view({'put': 'update'})),
    url(r'^soundmark/(?P<s_name>\w+)/$', views.SoundmarkView.as_view({'get': 'retrieve'})),
    url(r'^soundmark/$', views.SoundmarkView.as_view({'get': 'list'})),
]

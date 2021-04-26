from django.conf.urls import url
from django.urls import path

from . import views

urlpatterns = [
    url(r'^word/$', views.WordView.as_view({'post':'create', 'get':'list'})),
    url(r'^word/(?P<name>\w+)/$', views.WordView.as_view({'put':'update', 'get':'retrieve', 'delete':'destroy', })),
    #url(r'^word/update_audio/$', views.WordView.as_view({'put':'updateAudio'})),

    url(r'^word_tag/$', views.WordTagView.as_view({'post':'create', 'get':'list'})),
    url(r'^word_tag/(?P<pk>\w+)/$', views.WordTagView.as_view({'delete': 'destroy'})),

    url(r'^sentence/$', views.SentenceView.as_view({'post':'create', 'get':'list'})),
    url(r'^sentence/(?P<pk>\d+)/$', views.SentenceView.as_view({'put':'update', 'get':'retrieve', 'delete':'destroy'})),

    url(r'^sentence_tag/$', views.SentenceTagView.as_view({'post':'create', 'get':'list'})),
    url(r'^sentence_tag/(?P<pk>\w+)/$', views.SentenceTagView.as_view({'delete': 'destroy'})),

    url(r'^grammar/$', views.GrammarView.as_view({'post':'create', 'get':'list'})),
    url(r'^grammar/(?P<pk>\d+)/$', views.GrammarView.as_view({'put':'update', 'get':'retrieve', 'delete':'destroy'})),

    url(r'^grammar_type/$', views.GrammarTypeView.as_view({'post':'create', 'get':'list'})),
    url(r'^grammar_type/(?P<pk>\w+)/$', views.GrammarTypeView.as_view({'delete':'destroy'})),

    url(r'^grammar_tag/$', views.GrammarTagView.as_view({'post':'create', 'get':'list'})),
    url(r'^grammar_tag/(?P<pk>\w+)/$', views.GrammarTagView.as_view({'delete': 'destroy'})),

    url(r'^etyma/$', views.EtymaView.as_view({'post':'create', 'get':'list'})),
    url(r'^etyma/(?P<pk>\w+)/$', views.EtymaView.as_view({'put':'update', 'get':'retrieve', 'delete':'destroy'})),

    url(r'^distinguish_word/$', views.DistinguishWordView.as_view({'post':'create', 'get':'list'})),
    url(r'^distinguish_word/(?P<pk>\d+)/$', views.DistinguishWordView.as_view({'put':'update', 'get':'retrieve', 'delete':'destroy'})),

    url(r'^sentence_pattern/$', views.SentencePatternView.as_view({'post':'create', 'get':'list'})),
    url(r'^sentence_pattern/(?P<pk>\d+)/$', views.SentencePatternView.as_view({'put':'update', 'get':'retrieve', 'delete':'destroy'})),

    url(r'^paraphrase/$', views.ParaphraseView.as_view({'post':'create', 'get':'list'})),
    url(r'^paraphrase/(?P<pk>\d+)/$', views.ParaphraseView.as_view({'put':'update', 'get':'retrieve', 'delete':'destroy'})),

    url(r'^soundmark/$', views.SoundmarkView.as_view({'post':'create', 'get':'list'})),
    url(r'^soundmark/(?P<pk>\w+)/$', views.SoundmarkView.as_view({'put':'update', 'get':'retrieve', 'delete':'destroy'})),
]

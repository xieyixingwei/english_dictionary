from django.conf.urls import url
from django.urls import path

from . import views

urlpatterns = [
    url(r'^word/create/$', views.CreateWordView.as_view()),
    url(r'^word/(?P<w_name>\w+)/update/$', views.UpdateWordView.as_view()),
    url(r'^word/(?P<w_name>\w+)/$', views.RetrieveWordView.as_view()),

    url(r'^sentence/create/$', views.CreateSentenceView.as_view()),
    url(r'^sentence/(?P<pk>\d+)/update/$', views.UpdateSentenceView.as_view()),
    url(r'^sentence/(?P<pk>\d+)/$', views.RetrieveSentenceView.as_view()),

    url(r'^grammar/create/$', views.CreateGrammarView.as_view()),
    url(r'^grammar/(?P<pk>\d+)/update/$', views.UpdateGrammarView.as_view()),
    url(r'^grammar/(?P<pk>\d+)/$', views.RetrieveGrammarView.as_view()),

    url(r'^distinguish_word/create/$', views.CreateDistinguishWordView.as_view()),
    url(r'^distinguish_word/(?P<pk>\d+)/update/$', views.UpdateDistinguishWordView.as_view()),
    url(r'^distinguish_word/(?P<pk>\d+)/$', views.RetrieveDistinguishWordView.as_view()),

    url(r'^word_to_sentence/create/$', views.CreateWordToSentenceView.as_view()),
    url(r'^word_to_sentence/(?P<wtg_word>\w+)/update/$', views.UpdateWordToSentenceView.as_view()),
    url(r'^word_to_sentence/(?P<wtg_word>\w+)/$', views.ListWordToSentenceView.as_view()),

    url(r'^etyma/create/$', views.CreateEtymaView.as_view()),
    url(r'^etyma/(?P<e_name>\w+)/update/$', views.UpdateEtymaView.as_view()),
    url(r'^etyma/(?P<e_name>\w+)/$', views.RetrieveEtymaView.as_view()),

    url(r'^soundmark/create/$', views.CreateSoundmarkView.as_view()),
    url(r'^soundmark/(?P<s_name>\w+)/update/$', views.UpdateSoundmarkView.as_view()),
    url(r'^soundmark/(?P<s_name>\w+)/$', views.RetrieveSoundmarkView.as_view()),

    url(r'^relative_word/create/$', views.CreateRelativeWordView.as_view()),
    url(r'^relative_word/(?P<pk>\d+)/update/$', views.UpdateRelativeWordView.as_view()),
    url(r'^relative_word/(?P<r_word_a>\w+)/$', views.ListRelativeWordView.as_view()),

    url(r'^relative_sentence/create/$', views.CreateRelativeSentenceView.as_view()),
    url(r'^relative_sentence/(?P<pk>\d+)/update/$', views.UpdateRelativeSentenceView.as_view()),
    url(r'^relative_sentence/(?P<r_sentence_a>\w+)/$', views.ListRelativeSentenceView.as_view()),
]

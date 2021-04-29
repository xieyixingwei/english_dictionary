from django.conf.urls import url
from .views.WordView import WordView, WordTagView, EtymaView, SentencePatternView, ParaphraseView
from .views.SentenceView import SentenceView, SentenceTagView
from .views.GrammarView import GrammarView, GrammarTagView, GrammarTypeView
from .views.DistinguishWordView import DistinguishWordView
from .views.PronunciationView import SoundmarkView


urlpatterns = [
    url(r'^word/$', WordView.as_view({'post':'create', 'get':'list'})),
    url(r'^word/(?P<name>\w+)/$',WordView.as_view({'put':'update', 'get':'retrieve', 'delete':'destroy', })),

    url(r'^word_tag/$', WordTagView.as_view({'post':'create', 'get':'list'})),
    url(r'^word_tag/(?P<pk>\w+)/$', WordTagView.as_view({'delete': 'destroy'})),

    url(r'^sentence/$', SentenceView.as_view({'post':'create', 'get':'list'})),
    url(r'^sentence/(?P<pk>\d+)/$', SentenceView.as_view({'put':'update', 'get':'retrieve', 'delete':'destroy'})),

    url(r'^sentence_tag/$', SentenceTagView.as_view({'post':'create', 'get':'list'})),
    url(r'^sentence_tag/(?P<pk>\w+)/$', SentenceTagView.as_view({'delete': 'destroy'})),

    url(r'^grammar/$', GrammarView.as_view({'post':'create', 'get':'list'})),
    url(r'^grammar/(?P<pk>\d+)/$', GrammarView.as_view({'put':'update', 'get':'retrieve', 'delete':'destroy'})),

    url(r'^grammar_type/$', GrammarTypeView.as_view({'post':'create', 'get':'list'})),
    url(r'^grammar_type/(?P<pk>\w+)/$', GrammarTypeView.as_view({'delete':'destroy'})),

    url(r'^grammar_tag/$', GrammarTagView.as_view({'post':'create', 'get':'list'})),
    url(r'^grammar_tag/(?P<pk>\w+)/$', GrammarTagView.as_view({'delete': 'destroy'})),

    url(r'^etyma/$', EtymaView.as_view({'post':'create', 'get':'list'})),
    url(r'^etyma/(?P<pk>\w+)/$', EtymaView.as_view({'put':'update', 'get':'retrieve', 'delete':'destroy'})),

    url(r'^distinguish_word/$', DistinguishWordView.as_view({'post':'create', 'get':'list'})),
    url(r'^distinguish_word/(?P<pk>\d+)/$', DistinguishWordView.as_view({'put':'update', 'get':'retrieve', 'delete':'destroy'})),

    url(r'^sentence_pattern/$', SentencePatternView.as_view({'post':'create', 'get':'list'})),
    url(r'^sentence_pattern/(?P<pk>\d+)/$', SentencePatternView.as_view({'put':'update', 'get':'retrieve', 'delete':'destroy'})),

    url(r'^paraphrase/$', ParaphraseView.as_view({'post':'create', 'get':'list'})),
    url(r'^paraphrase/(?P<pk>\d+)/$', ParaphraseView.as_view({'put':'update', 'get':'retrieve', 'delete':'destroy'})),

    url(r'^soundmark/$', SoundmarkView.as_view({'post':'create', 'get':'list'})),
    url(r'^soundmark/(?P<pk>\w+)/$', SoundmarkView.as_view({'put':'update', 'get':'retrieve', 'delete':'destroy'})),
]

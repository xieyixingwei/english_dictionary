from django.conf.urls import url
from django.urls import path

from study.views.StudyPlanView import StudyPlanView
from study.views.StudyWordView import StudyWordView
from study.views.StudySentenceView import StudySentenceView
from study.views.StudyGrammarView import StudyGrammarView
from study.views.StudySentencePatternView import StudySentencePatternView


urlpatterns = [
    url(r'^plan/$', StudyPlanView.as_view({'post':'create'})),
    url(r'^plan/(?P<pk>\d+)/$', StudyPlanView.as_view({'put':'update', 'get':'retrieve', 'delete': 'destroy'})),

    url(r'^word/$', StudyWordView.as_view({'post':'create', 'get': 'list'})),
    url(r'^word/(?P<pk>\d+)/$', StudyWordView.as_view({'put':'update', 'get':'retrieve', 'delete': 'destroy'})),

    url(r'^sentence/$', StudySentenceView.as_view({'post':'create', 'get': 'list'})),
    url(r'^sentence/(?P<pk>\d+)/$', StudySentenceView.as_view({'put':'update', 'get':'retrieve', 'delete': 'destroy'})),

    url(r'^sentence_pattern/$', StudySentencePatternView.as_view({'post':'create', 'get': 'list'})),
    url(r'^sentence_pattern/(?P<pk>\d+)/$', StudySentencePatternView.as_view({'put':'update', 'get':'retrieve', 'delete': 'destroy'})),

    url(r'^grammar/$', StudyGrammarView.as_view({'post':'create', 'get': 'list'})),
    url(r'^grammar/(?P<pk>\d+)/$', StudyGrammarView.as_view({'put':'update', 'get':'retrieve', 'delete': 'destroy'})),
]

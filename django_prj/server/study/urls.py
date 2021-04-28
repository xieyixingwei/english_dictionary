from django.conf.urls import url
from django.urls import path

from study.views.StudyPlanView import StudyPlanView
from study.views.StudyWordView import StudyWordView
from study.views.StudySentenceView import StudySentenceView
from study.views.StudyGrammerView import StudyGrammerView


urlpatterns = [
    url(r'^plan/$', StudyPlanView.as_view({'post':'create'})),
    url(r'^plan/(?P<pk>\d+)/$', StudyPlanView.as_view({'put':'update', 'get':'retrieve'})),

    url(r'^word/$', StudyWordView.as_view({'post':'create', 'get': 'list'})),
    url(r'^word/(?P<pk>\d+)/$', StudyWordView.as_view({'put':'update', 'get':'retrieve', 'delete': 'destroy'})),

    url(r'^sentence/$', StudySentenceView.as_view({'post':'create', 'get': 'list'})),
    url(r'^sentence/(?P<pk>\d+)/$', StudySentenceView.as_view({'put':'update', 'get':'retrieve', 'delete': 'destroy'})),

    url(r'^grammer/$', StudyGrammerView.as_view({'post':'create', 'get': 'list'})),
    url(r'^grammer/(?P<pk>\d+)/$', StudyGrammerView.as_view({'put':'update', 'get':'retrieve', 'delete': 'destroy'})),
]

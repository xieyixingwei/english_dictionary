from django.conf.urls import url
from django.urls import path

from . import views

urlpatterns = [
    url(r'^register/$', views.RegisterView.as_view()),
    url(r'^login/$', views.LoginView.as_view()),
    url(r'^$', views.UsersView.as_view({'get': 'list'})),
    url(r'^(?P<uname>\w+)/$', views.UsersView.as_view(
        {
            'get': 'retrieve',
            'delete': 'destroy',
            'put': 'update',
        })),
    url(r'^create_admin/$', views.UsersView.as_view({'post': 'create'})),
    url(r'^change_admin/(?P<uname>\w+)/$', views.ChangeAmindUserView.as_view()),
]

#url(r'^users/login/$', views.UsersView.as_view(
#    {
#        'post': 'login',
#    }
#)),
#         {
#            'get': 'retrieve',
#            'delete': 'destroy',
#        }

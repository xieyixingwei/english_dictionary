from django.conf.urls import url
from django.urls import path

from . import views

urlpatterns = [
    url(r'^register/$', views.RegisterView.as_view()),
    url(r'^login/$', views.LoginView.as_view()),
    url(r'^list/$', views.UsersView.as_view({'get': 'list'})),
    url(r'^create_admin/$', views.UsersView.as_view({'post': 'create'})),
    url(r'^(?P<u_uname>\w+)/$', views.UsersView.as_view({'get': 'retrieve'})),
    url(r'^delete/(?P<u_uname>\w+)/$', views.UsersView.as_view({'delete': 'destroy'})),
    url(r'^update/(?P<u_uname>\w+)/$', views.UsersView.as_view({'put': 'update'})),
    url(r'^change_admin/(?P<u_uname>\w+)/$', views.UsersView.as_view({'put': 'update'})),
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

from django.conf.urls import url
from django.urls import path

from . import views

urlpatterns = [
    url(r'^register/$', views.RegisterView.as_view()),
    url(r'^login/$', views.LoginView.as_view()),
    url(r'^list/$', views.ListUsersView.as_view()),
    url(r'^create_admin/$', views.CreateAdminUserView.as_view()),
    url(r'^(?P<pk>\d+)/$', views.RetrieveUserView.as_view()),
    url(r'^(?P<pk>\d+)/delete/$', views.DeleteUserView.as_view()),
    url(r'^(?P<pk>\d+)/update/$', views.UpdateUserView.as_view()),
    url(r'^(?P<pk>\d+)/change_admin/$', views.ChangeAmindUserView.as_view()),
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

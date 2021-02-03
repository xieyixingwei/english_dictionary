from django.conf.urls import url
from django.urls import path

from . import views

urlpatterns = [
    url(r'^register/$', views.RegisterView.as_view()),
    url(r'^login/$', views.LoginView.as_view()),
    url(r'^list/$', views.ListUsersView.as_view()),
    url(r'^create_admin/$', views.CreateAdminUserView.as_view()),
    url(r'^(?P<u_uname>\w+)/$', views.RetrieveUserView.as_view()),
    url(r'^(?P<u_uname>\w+)/delete/$', views.DeleteUserView.as_view()),
    url(r'^(?P<u_uname>\w+)/update/$', views.UpdateUserView.as_view()),
    url(r'^(?P<u_uname>\w+)/change_admin/$', views.ChangeAmindUserView.as_view()),
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

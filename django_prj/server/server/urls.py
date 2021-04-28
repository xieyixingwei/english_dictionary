"""server URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
# from django.contrib import admin
from django.urls import path
from django.conf.urls import url, include

# 在debug模式下要访问上传的文件需要在 urlpatterns 里设置 static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
from server import settings
from django.conf.urls.static import static

urlpatterns = [
    # path('admin/', admin.site.urls),
    url(r'^dictionary/', include(('dictionary.urls', 'dictionary'), namespace='dictionary')),
    url(r'^user/', include(('user.urls', 'user'), namespace='user')),
    url(r'^study/', include(('study.urls', 'study'), namespace='study')),
]  + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

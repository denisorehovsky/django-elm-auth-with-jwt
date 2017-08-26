from django.conf.urls import url
from django.contrib import admin

from rest_framework_jwt.views import obtain_jwt_token

urlpatterns = [
    url(r'^api/v1/token/obtain/', obtain_jwt_token),
    url(r'^admin/', admin.site.urls),
]

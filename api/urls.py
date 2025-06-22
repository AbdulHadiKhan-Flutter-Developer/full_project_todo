
from django.urls import include, path
from .views import GetData,GetUpdateDeleteData

urlpatterns = [
path('todo/',GetData.as_view()),
path('todo/<int:pk>/',GetUpdateDeleteData.as_view())
]

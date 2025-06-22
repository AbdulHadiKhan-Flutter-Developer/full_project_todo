from django.urls import path
from django.http import JsonResponse
from .views import GetData, GetUpdateDeleteData

def api_home(request):
    return JsonResponse({"message": "Todo API is running ✅"})

urlpatterns = [
    path('', api_home),  # 👈 handles "/"
    path('todo/', GetData.as_view()),
    path('todo/<int:pk>/', GetUpdateDeleteData.as_view()),
]

from rest_framework import generics
from .models import Todo
from .serializers import TodoSerializer
# Create your views here.

class GetData(generics.ListCreateAPIView):
    queryset = Todo.objects.all()
    serializer_class = TodoSerializer


class GetUpdateDeleteData(generics.RetrieveUpdateDestroyAPIView):
    queryset = Todo.objects.all()
    serializer_class = TodoSerializer    

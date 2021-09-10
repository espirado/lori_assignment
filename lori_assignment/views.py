from django.shortcuts import render
from django.views.decorators.csrf import csrf_exempt

@csrf_exempt
def index(request):
    return render(request, "index.html", {})

@csrf_exempt
def home(request):
    if request.user.is_authenticated:
        return render(request, "home.html", {"user":request.user, "id":request.user.id})
    else:
        return render(request, "index.html", {})
    
@csrf_exempt
def balance(request):
    if request.user.is_authenticated:
        return render(request, "balance.html", {"user":request.user, "id":request.user.id})
    else:
        return render(request, "index.html", {})
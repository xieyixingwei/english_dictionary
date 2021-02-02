from django.core.cache import cache
from rest_framework import permissions
from user.models import User
from server.settings import ROOT_USERS
from rest_framework import request
from django.urls import re_path


SAFE_METHODS = ('GET', 'HEAD', 'OPTIONS')


class AllowAny(permissions.BasePermission):
    """
    Allow any access.
    """
    def has_permission(self, request, view):
        return True


class IsAuthenticated(permissions.BasePermission):
    """
    Allows access only to authenticated users.
    """
    def has_permission(self, request, view):
        return bool(isinstance(request.user, User) and request.user.is_authenticated)


class IsAuthenticatedAndSelf(permissions.BasePermission):
    """
    Allows access only to authenticated users and self.
    """
    def has_permission(self, request:request.Request, view):
        return bool(isinstance(request.user, User) and
                    request.user.is_authenticated and
                    request._request.resolver_match.kwargs['pk'] == str(request.user.u_id))


class IsAdminUser(permissions.BasePermission):
    """
    Allows access only to admin users.
    """
    def has_permission(self, request, view):
        return bool(isinstance(request.user, User) and request.user.u_is_admin)


class IsRootUser(permissions.BasePermission):
    """
    Allows access only to root users.
    """
    def has_permission(self, request, view):
        return bool(isinstance(request.user, User) and (request.user.u_uname in ROOT_USERS))


class CallbackAuthenticated(permissions.BasePermission):
    """
    Allows access only to authenticated users and self.
    """
    def __init__(self, callback):
        self._callback = callback

    def has_permission(self, request:request.Request, view):
        return bool(isinstance(request.user, User) and
                    request.user.is_authenticated and
                    self._callback(request))

class IsAuthenticatedOrReadOnly(permissions.BasePermission):
    """
    The request is authenticated as a user, or is a read-only request.
    """
    def has_permission(self, request, view):
        return bool(
            request.method in SAFE_METHODS or
            request.user and
            request.user.is_authenticated
        )

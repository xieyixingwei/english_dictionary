from django.core.cache import cache
from rest_framework import permissions
from user.models import UserTable
from server.settings import ROOT_USERS
from rest_framework import request


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
        return bool(isinstance(request.user, UserTable) and request.user.isAuthenticated)


class IsAdminUser(permissions.BasePermission):
    """
    Allows access only to admin users.
    """
    def has_permission(self, request, view):
        return bool(isinstance(request.user, UserTable) and request.user.isAdmin)


class IsRootUser(permissions.BasePermission):
    """
    Allows access only to root users.
    """
    def has_permission(self, request, view):
        return bool(isinstance(request.user, UserTable) and (request.user.uname in ROOT_USERS))


class IsAuthenticatedOrReadOnly(permissions.BasePermission):
    """
    The request is authenticated as a user, or is a read-only request.
    """
    def has_permission(self, request, view):
        return bool(
            request.method in SAFE_METHODS or
            request.user and
            request.user.isAuthenticated
        )

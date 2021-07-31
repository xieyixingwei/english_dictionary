from rest_framework import viewsets, serializers


class ModelViewSetPermissionSerializerMap(viewsets.ModelViewSet):
    """
    support permission_classes_map and serializer_class_map.
    permission_classes_map = { 'method': (permissions,), }
    serializer_class_map = { 'method': serializer, }
    """

    permission_classes_map = {}
    serializer_class_map = {}

    def initial(self, request, *args, **kwargs):
        """
        redefine initial() of rest_framework.views.APIView
        """
        method = request.method.lower()
        if method in self.http_method_names:
            handler = getattr(self, method, self.http_method_not_allowed)
        else:
            handler = self.http_method_not_allowed

        handler_name = None
        if hasattr(handler, '__name__'):
            handler_name = handler.__name__
        elif hasattr(handler, '__func__'):
            handler_name = handler.__func__.__name__

        if handler_name and handler_name in self.permission_classes_map:
            permissions = self.permission_classes_map.get(handler_name)
            if isinstance(permissions, (tuple, list)):
                self.permission_classes = permissions

        if handler_name and handler_name in self.serializer_class_map:
            self.serializer_class = self.serializer_class_map.get(handler_name)
            #if isinstance(serializer, serializers.ModelSerializer):

        return super().initial(request, *args, **kwargs)

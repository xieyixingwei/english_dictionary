from django.db import models
import json


class JSONFieldUtf8(models.JSONField):
    def __init__(
        self, verbose_name=None, name=None, encoder=None, decoder=None,
        **kwargs,
    ):
        super().__init__(verbose_name, name, encoder, decoder, **kwargs)

    def get_prep_value(self, value):
        if value is None:
            return value
            # dumps() add ensure_ascii=False to support chinese
        return json.dumps(value, ensure_ascii=False, cls=self.encoder)

from rest_framework import serializers
from rest_framework.utils import html
from rest_framework.fields import empty
import re
from django.utils.datastructures import MultiValueDict


def _parse_html_list(dictionary, prefix='', default=None):
    """
    代替 html.parse_html_list()
    解决 不能解析 'sentencesForeign[0][en]': ['hello'], 'sentencesForeign[0][cn]': ['你好']
    """
    ret = {}
    regex = re.compile(r'^%s\[([0-9]+)\]\[(.*)\]$' % re.escape(prefix))
    for field, value in dictionary.items():
        match = regex.match(field)
        if not match:
            continue
        index, key = match.groups()
        index = int(index)
        if not key:
            ret[index] = value
        elif isinstance(ret.get(index), dict):
            ret[index][key] = value
        else:
            ret[index] = MultiValueDict({key: [value]})

    # return the items of the ``ret`` dict, sorted by key, or ``default
    return [ret[item] for item in sorted(ret)] if ret else default


class ListSerializer(serializers.ListSerializer):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

    def get_value(self, dictionary):
        """
        Given the input dictionary, return the field value.
        """
        # We override the default field access in order to support
        # lists in HTML forms.
        print('--- ListSerializer', dictionary)
        if html.is_html_input(dictionary):
            return _parse_html_list(dictionary, prefix=self.field_name, default=empty) # 代替 html.parse_html_list()
        return dictionary.get(self.field_name, empty)

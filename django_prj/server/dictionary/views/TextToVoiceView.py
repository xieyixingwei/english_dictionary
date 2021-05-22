from django.views import View
from django.http import HttpResponse
import uuid
import shutil
import os

from ..voice_text import text_to_mp3
from server.settings import STATIC_ROOT


class TextToVoiceView(View):
    savePath = STATIC_ROOT / 'tmp'

    def get(self, request):
        fname = 'text_to_voice_%s.mp3' % uuid.uuid4().hex[0:8]
        self._clearStaticTmp()

        try:
            text = request.GET.get('text')
            lang = request.GET.get('lang')
            text_to_mp3(text, self.savePath / fname, lang)
        except Exception as e:
            return HttpResponse("failed")
        return HttpResponse('/static/tmp/%s' % fname)

    def _clearStaticTmp(self):
        shutil.rmtree(self.savePath)
        os.mkdir(self.savePath)


from django.views import View
from django.http import HttpResponse
import uuid
import shutil
import os

from ..voice_text import text_to_mp3
from server.settings import STATIC_ROOT


class TextToVoiceView(View):
    savePath = STATIC_ROOT / 'sentences'

    def get(self, request):
        id = request.GET.get('id')
        lang = request.GET.get('lang')
        fname = 'sentence_%s_%s.mp3' % (id, lang)
        if os.path.exists(self.savePath / fname):
            return HttpResponse('/static/sentences/%s' % fname)
        try:
            text = request.GET.get('text')
            text_to_mp3(text, self.savePath / fname, lang)
        except Exception as e:
            return HttpResponse("failed")
        return HttpResponse('/static/sentences/%s' % fname)

    def _clearStaticTmp(self):
        shutil.rmtree(self.savePath)
        os.mkdir(self.savePath)


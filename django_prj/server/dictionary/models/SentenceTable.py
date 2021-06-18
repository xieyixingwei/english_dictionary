from django.db import models
import hashlib
import re
import os

from server.models  import JSONFieldUtf8
from dictionary.models.ParaphraseTable import ParaphraseTable
from dictionary.models.DialogTable import DialogTable
from django.core.files.base import ContentFile
from ..voice_text import text_to_mp3fp
from server.settings import MEDIA_ROOT


class SentenceTable(models.Model):
    """
    句子表
    """
    id = models.AutoField(primary_key=True)
    en = models.CharField(max_length=512) # 英文
    enVoice = models.FileField(upload_to='sentence_voice/', null=True, blank=True, verbose_name="英文例句发音")
    cn = models.CharField(max_length=512, null=True) # 中文
    cnVoice = models.FileField(upload_to='sentence_voice/', null=True, blank=True, verbose_name="中文例句发音")
    type = models.IntegerField(default=0)  # sentence|phrase|词汇搭配
    tag = JSONFieldUtf8(null=True)    # 标记 [日常用语,商务用语]
    tense = models.CharField(max_length=32, null=True, blank=True)   # 时态 [一般过去式,被动语态]
    pattern = JSONFieldUtf8(null=True)    # 句型 [复合句,问候语,从句,陈述句]
    synonym = models.ManyToManyField(to='self', blank=True) # 同义句 [Sentence.id,Sentence.id,...]
    antonym = models.ManyToManyField(to='self', blank=True) # 反义句 [Sentence.id,Sentence.id,...]
    paraphraseForeign = models.ForeignKey(to=ParaphraseTable, related_name='sentenceSet', null=True, on_delete=models.SET_NULL)
    dialogForeign = models.ForeignKey(to=DialogTable, related_name='sentenceSet', null=True, on_delete=models.SET_NULL)
    class Meta:
        ordering = ['id']  # 消除list警告UnorderedObjectListWarning: Pagination may yield inconsistent results with an unordered object_list

    def save(self, *args, **kwargs):
        # when create, id is None
        if self.id == None :
            super().save(*args, **kwargs)
        self._fill_en_voice()
        kwargs['force_insert'] = False
        super().save(*args, **kwargs)

    def _fill_en_voice(self):
        """
        自动填充英文例句的音频
        """
        def pickup_hash_from_filename(filename):
            if filename == None:
                return None
            matches = re.findall(r"^.*_en_(\w+)\.mp3", filename)
            return matches[0] if len(matches) > 0 else None

        curHash = hashlib.md5(self.en.encode('utf-8')).hexdigest()[0:6]
        oldHash = pickup_hash_from_filename(self.enVoice.name)
        if curHash == oldHash and os.path.exists(MEDIA_ROOT / self.enVoice.name):
            return
        if self.enVoice.name != None \
            and len(self.enVoice.name) > 0 \
            and os.path.exists(MEDIA_ROOT / self.enVoice.name):
            os.remove(MEDIA_ROOT / self.enVoice.name)

        tempFile = MEDIA_ROOT / 'sentence_voice/temp.mp3'
        fname = '%d_en_%s.mp3' % (self.id, curHash)
        with open(tempFile, 'wb') as fp:
            text_to_mp3fp(text=self.en, fp=fp, lang='en')
        with open(tempFile, 'rb') as fp:
            fileContent = ContentFile(fp.read())
            pathName = self.enVoice.field.upload_to + fname
            self.enVoice.name = pathName
            self.enVoice.storage.save(pathName, fileContent)

class SentenceTagTable(models.Model):
    """
    句子 Tags
    """
    name = models.CharField(max_length=32, primary_key=True)

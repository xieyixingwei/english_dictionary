from django.db import models
import hashlib

from server.models  import JSONFieldUtf8
from dictionary.models.ParaphraseTable import ParaphraseTable
from dictionary.models.DialogTable import DialogTable
from django.core.files.base import ContentFile
from ..voice_text import text_to_mp3fp
from server.settings import MEDIA_ROOT
import re


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
    paraphraseForeign = models.ForeignKey(to=ParaphraseTable, related_name='sentenceSet', null=True, on_delete=models.CASCADE)
    dialogForeign = models.ForeignKey(to=DialogTable, related_name='sentenceSet', null=True, on_delete=models.SET_NULL)
    class Meta:
        ordering = ['id']  # 消除list警告UnorderedObjectListWarning: Pagination may yield inconsistent results with an unordered object_list

    def save(self, *args, **kwargs):
        # when create, id is None
        if self.id == None :
            super().save(*args, **kwargs)
            return

        tempFile = MEDIA_ROOT / 'sentence_voice/temp.mp3'
        enHash = hashlib.md5(self.en.encode('utf-8')).hexdigest()[0:6]
        if self.enVoice.name == None\
            or self.enVoice.name == ''\
            or enHash != self.hashFromName(self.enVoice.name):
            fname = '%d_en_%s.mp3' % (self.id, enHash)
            with open(tempFile, 'wb') as fp:
                text_to_mp3fp(text=self.en, fp=fp, lang='en')
            with open(tempFile, 'rb') as fp:
                fileContent = ContentFile(fp.read())
                pathName = self.enVoice.field.upload_to + fname
                self.enVoice.name = pathName
                self.enVoice.storage.save(pathName, fileContent)
        super().save(*args, **kwargs)

    def hashFromName(self, name:str):
        _hash = re.findall(r"^.*_en_(\w+)\.mp3", name)
        return _hash[0]

class SentenceTagTable(models.Model):
    """
    句子 Tags
    """
    name = models.CharField(max_length=32, primary_key=True)

from django.db import models
from dictionary.models.WordTable import WordTable
from dictionary.models.SentencePatternTable import SentencePatternTable


class ParaphraseTable(models.Model):
    """
    释义表
    """
    id = models.AutoField(primary_key=True)
    interpret = models.CharField(max_length=128)     # 翻译\含义
    partOfSpeech = models.CharField(max_length=32)   # 词性
    wordForeign = models.ForeignKey(to=WordTable, null=True, related_name='paraphraseSet', on_delete=models.CASCADE)
    sentencePatternForeign = models.ForeignKey(to=SentencePatternTable, null=True, related_name='paraphraseSet', on_delete=models.CASCADE)
    class Meta:
        ordering = ['id'] 

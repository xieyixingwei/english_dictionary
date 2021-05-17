from django.db import models
from dictionary.models.WordTable import WordTable


class SentencePatternTable(models.Model):
    """
    常用句型表
    """
    id = models.AutoField(primary_key=True)
    content = models.CharField(max_length=64)  # 内容
    wordForeign = models.ForeignKey(to=WordTable, related_name='sentencePatternSet', null=True, on_delete=models.CASCADE)

    class Meta:
        ordering = ['id']

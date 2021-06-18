from django.db import models
from dictionary.models.WordTable import WordTable


class SentencePatternTable(models.Model):
    """
    固定表达表
    """
    id = models.AutoField(primary_key=True)
    content = models.CharField(max_length=64)  # 内容
    wordForeign = models.ForeignKey(to=WordTable, related_name='sentencePatternSet', null=True, on_delete=models.SET_NULL)

    class Meta:
        ordering = ['id']

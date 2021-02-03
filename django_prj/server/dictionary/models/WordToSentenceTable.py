from django.db import models
from dictionary.models import WordTable, SentenceTable


class WordToSentenceTable(models.Model):
    """
    单词表 - 句子表
    """
    wtg_id = models.AutoField(primary_key=True)
    wtg_word = models.ForeignKey(to=WordTable, related_name='sentences', on_delete=models.CASCADE)
    wtg_sentence = models.ForeignKey(to=SentenceTable, on_delete=models.CASCADE)
    wtg_info = models.CharField(max_length=32) # 所属word的类型 "n.1"/"v.2"/"phase"/词汇搭配/常用句型

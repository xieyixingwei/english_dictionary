from django.db import models
from .word_tb import Word
from .sentence import Sentence


class WordToSentence(models.Model):
    """
    单词表 - 句子表
    """
    wtg_id = models.AutoField(primary_key=True)
    wtg_word = models.ForeignKey(to=Word, on_delete=models.CASCADE)
    wtg_sentence = models.ForeignKey(to=Sentence, on_delete=models.CASCADE)
    wtg_info = models.CharField(max_length=32) # 所属word的类型 "n.:1"/"v.:2"/"phase"/词汇搭配/常用句型
    class Meta:
        db_table = "word_to_sentence"

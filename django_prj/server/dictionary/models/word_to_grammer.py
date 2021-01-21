from django.db import models
from .word import Word
from .grammer import Grammar


class WordToGrammer(models.Model):
    """
    单词表 - 语法表
    """
    wtg_id = models.AutoField(primary_key=True)
    wtg_word = models.ForeignKey(to=Word, on_delete=models.CASCADE)
    wtg_grammer = models.ForeignKey(to=Grammar, on_delete=models.CASCADE)
    class Meta:
        db_table = "word_to_grammer"

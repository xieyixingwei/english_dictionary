from django.db import models
from .sentence import Sentence
from .grammer import Grammar


class SentenceToGrammer(models.Model):
    """
    句子表 - 语法表
    """
    wtg_id = models.AutoField(primary_key=True)
    wtg_sentence = models.ForeignKey(to=Sentence, on_delete=models.CASCADE)
    wtg_grammer = models.ForeignKey(to=Grammar, on_delete=models.CASCADE)
    class Meta:
        db_table = "sentence_to_grammer"

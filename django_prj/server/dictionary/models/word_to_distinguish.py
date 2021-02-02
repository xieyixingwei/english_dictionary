from django.db import models
from .word_tb import Word
from .distinguish import Distinguish

class WordToDistinguish(models.Model):
    """
    单词表 - 词义辨析表
    """
    wtd_id = models.AutoField(primary_key=True)
    wtd_word = models.ForeignKey(to=Word, on_delete=models.CASCADE)
    wtd_distinguish = models.ForeignKey(to=Distinguish, on_delete=models.CASCADE)
    class Meta:
        db_table = "word_to_distinguish"

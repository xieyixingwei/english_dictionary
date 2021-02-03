from django.db import models
from dictionary.models import SentenceTable


class RelativeSentenceTable(models.Model):
    """
    近义句/反义句表
    """
    r_id = models.AutoField(primary_key=True)
    r_sentence_a = models.ForeignKey(to=SentenceTable, related_name='master_sentence', on_delete=models.CASCADE)
    r_sentence_b = models.ForeignKey(to=SentenceTable, on_delete=models.CASCADE)
    r_type = models.BooleanField(default=True) # True 近义句 | False 反义句

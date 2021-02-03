from django.db import models
from dictionary.models import WordTable


class RelativeWordTable(models.Model):
    """
    近义词/反义词表
    """
    r_id = models.AutoField(primary_key=True)
    r_word_a = models.ForeignKey(to=WordTable, related_name='master_word', on_delete=models.CASCADE)
    r_word_b = models.ForeignKey(to=WordTable, on_delete=models.CASCADE)
    r_type = models.BooleanField(default=True) # True 近义词 | False 反义词

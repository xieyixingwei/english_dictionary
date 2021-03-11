from django.db import models
from user.models import UserTable
from dictionary.models import WordTable
from server.models  import JSONFieldUtf8


class StudyWordTable(models.Model):
    """
    单词学习表
    """
    id = models.AutoField(primary_key=True)
    foreignUser = models.ForeignKey(to=UserTable, on_delete=models.CASCADE)
    foreignWord = models.ForeignKey(to=WordTable, on_delete=models.CASCADE)
    collect = JSONFieldUtf8()        # 单词本 [a,b]
    familiarity = models.IntegerField() # 0 ~ 5
    repeats = models.IntegerField()
    learnRecord = JSONFieldUtf8() # [09122030,09112030,09102030]
    inplan = models.BooleanField()
    comments = models.CharField(max_length=256) # markdown

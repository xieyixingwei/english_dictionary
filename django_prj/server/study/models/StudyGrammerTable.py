from django.db import models
from user.models import UserTable
from dictionary.models import GrammarTable
from server.models  import JSONFieldUtf8


class StudyGrammerTable(models.Model):
    """
    语法学习表
    """
    id = models.AutoField(primary_key=True)
    foreignUser = models.ForeignKey(to=UserTable, on_delete=models.CASCADE)
    foreignGrammer = models.ForeignKey(to=GrammarTable, on_delete=models.CASCADE)
    familiarity = models.IntegerField() # 0 ~ 5
    repeats = models.IntegerField()
    learnRecord = JSONFieldUtf8() # [09122030,09112030,09102030]
    inplan = models.BooleanField()
    comments = models.CharField(max_length=256)  # markdown

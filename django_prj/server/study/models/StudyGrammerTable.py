from django.db import models
from user.models import UserTable
from dictionary.models import GrammarTable
from server.models  import JSONFieldUtf8


class StudyGrammerTable(models.Model):
    """
    语法学习表
    """
    sg_id = models.AutoField(primary_key=True)
    sg_user = models.ForeignKey(to=UserTable, on_delete=models.CASCADE)
    sg_grammer = models.ForeignKey(to=GrammarTable, on_delete=models.CASCADE)
    sg_familiarity = models.IntegerField() # 0 ~ 5
    sg_repeats = models.IntegerField()
    sg_learn_record = JSONFieldUtf8() # [09122030,09112030,09102030]
    sg_inplan = models.BooleanField()
    sg_comments = models.CharField(max_length=256)  # markdown

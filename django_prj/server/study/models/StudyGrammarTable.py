from django.db import models
from user.models import UserTable
from dictionary.models import GrammarTable
from server.models  import JSONFieldUtf8


class StudyGrammarTable(models.Model):
    """
    语法学习表
    """
    id = models.AutoField(primary_key=True)
    foreignUser = models.ForeignKey(to=UserTable, related_name='studyGrammerSet', on_delete=models.CASCADE)
    grammar = models.OneToOneField(to=GrammarTable, on_delete=models.CASCADE)
    category = models.CharField(max_length=30, null=True, blank=True)     # 所属的单词本
    familiarity = models.IntegerField(default=0) # 0 ~ 5
    learnRecord = JSONFieldUtf8(null=True) # [09122030,09112030,09102030]
    inplan = models.BooleanField(default=False)
    isFavorite = models.BooleanField(default=False)
    repeats = models.IntegerField(default=0)

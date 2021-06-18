from django.db import models
from user.models import UserTable
from server.models  import JSONFieldUtf8


class StudyPlanTable(models.Model):
    """
    学习计划表
    """
    id = models.AutoField(primary_key=True)
    foreignUser = models.OneToOneField(to=UserTable, related_name='studyPlan', on_delete=models.CASCADE)
    onceWords = models.IntegerField(null=True, blank=True)
    onceSentences = models.IntegerField(null=True, blank=True)
    onceGrammers = models.IntegerField(null=True, blank=True)
    wordCategories = JSONFieldUtf8(null=True, blank=True) # 单词本名字 [a,b]
    sentenceCategories = JSONFieldUtf8(null=True, blank=True) # 句子本名字 [a,b]
    grammarCategories = JSONFieldUtf8(null=True, blank=True) # 语法本名字 [a,b]
    distinguishes = JSONFieldUtf8(null=True, blank=True) # 收藏的词义辨析
    sentencePatternCategories = JSONFieldUtf8(null=True, blank=True)

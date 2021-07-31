from django.db import models
from user.models import UserTable
from dictionary.models.WordTable import WordTable
from server.models  import JSONFieldUtf8


class StudyWordTable(models.Model):
    """
    单词学习表
    """
    id = models.AutoField(primary_key=True)
    foreignUser = models.ForeignKey(to=UserTable, related_name='studyWordSet', on_delete=models.CASCADE)  # 所属的用户
    word = models.ForeignKey(to=WordTable, related_name='studyWordSet', null=True, on_delete=models.CASCADE)  # 单词
    categories = JSONFieldUtf8(null=True, blank=True) # models.CharField(max_length=30, null=True, blank=True)     # 所属的单词本 
    familiarity = models.IntegerField(default=0)                             # 熟悉程度 0 ~ 5
    learnRecord = JSONFieldUtf8(null=True, blank=True)                       # 学习时间历史记录 [09122030,09112030,09102030]
    inplan = models.BooleanField(default=False)                              # 是否在学习计划中
    isFavorite = models.BooleanField(default=False)                          # 是否被收藏
    comments = models.CharField(max_length=256, null=True, blank=True)       # 个人添加的comments markdown
    repeats = models.IntegerField(default=0)                                 # 被学了多少次
    class Meta:
        ordering = ['id']

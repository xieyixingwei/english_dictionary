from django.db import models
from user.models import UserTable
from dictionary.models.SentencePatternTable import SentencePatternTable
from server.models  import JSONFieldUtf8


class StudySentencePatternTable(models.Model):
    """
    固定表达学习表
    """
    id = models.AutoField(primary_key=True)
    foreignUser = models.ForeignKey(to=UserTable, related_name='studySentencePatternSet', on_delete=models.CASCADE)
    sentencePattern = models.ForeignKey(to=SentencePatternTable, related_name='studySentencePatternSet', null=True, on_delete=models.CASCADE)
    categories = JSONFieldUtf8(null=True, blank=True) #models.CharField(max_length=30, null=True, blank=True)     # 所属的单词本
    familiarity = models.IntegerField(default=0) # 0 ~ 5
    learnRecord = JSONFieldUtf8(null=True, blank=True) # [09122030,09112030,09102030]
    inplan = models.BooleanField(default=False)
    isFavorite = models.BooleanField(default=False)
    comments = models.CharField(max_length=256, null=True, blank=True)  # markdown
    repeats = models.IntegerField(default=0)
    class Meta:
        ordering = ['id']

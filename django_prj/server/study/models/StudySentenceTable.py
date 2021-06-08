from django.db import models
from user.models import UserTable
from dictionary.models.SentenceTable import SentenceTable
from server.models  import JSONFieldUtf8


class StudySentenceTable(models.Model):
    """
    句子学习表
    """
    id = models.AutoField(primary_key=True)
    foreignUser = models.ForeignKey(to=UserTable, related_name='studySentenceSet', on_delete=models.CASCADE)
    sentence = models.OneToOneField(to=SentenceTable, null=True, on_delete=models.CASCADE)
    category = models.CharField(max_length=30, null=True, blank=True)     # 所属的单词本
    familiarity = models.IntegerField(default=0) # 0 ~ 5
    learnRecord = JSONFieldUtf8(null=True, blank=True) # [09122030,09112030,09102030]
    inplan = models.BooleanField(default=False)
    isFavorite = models.BooleanField(default=False)
    comments = models.CharField(max_length=256, null=True, blank=True)  # markdown
    repeats = models.IntegerField(default=0)
    newWords = JSONFieldUtf8(null=True, blank=True)   # 生词 [w1,w2]
    class Meta:
        ordering = ['id']

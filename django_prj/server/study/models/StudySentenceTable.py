from django.db import models
from dictionary.models.WordTable import WordTable
from user.models import UserTable
from dictionary.models.SentenceTable import SentenceTable
from dictionary.models.SentencePatternTable import SentencePatternTable
from server.models  import JSONFieldUtf8


class StudySentenceTable(models.Model):
    """
    句子学习表
    """
    id = models.AutoField(primary_key=True)
    foreignUser = models.ForeignKey(to=UserTable, related_name='studySentenceSet', on_delete=models.CASCADE)
    sentence = models.ForeignKey(to=SentenceTable, related_name='studySentenceSet', null=True, on_delete=models.CASCADE)
    categories = JSONFieldUtf8(null=True, blank=True) #models.CharField(max_length=30, null=True, blank=True)     # 所属的单词本
    familiarity = models.IntegerField(default=0) # 0 ~ 5
    learnRecord = JSONFieldUtf8(null=True, blank=True) # [09122030,09112030,09102030]
    inplan = models.BooleanField(default=False)
    isFavorite = models.BooleanField(default=False)
    comments = models.CharField(max_length=256, null=True, blank=True)  # markdown
    repeats = models.IntegerField(default=0)
    newWords = models.ManyToManyField(to=WordTable, blank=True) #JSONFieldUtf8(null=True, blank=True)   # 生词 [w1,w2]
    newSentencePatterns = models.ManyToManyField(to=SentencePatternTable, blank=True) # 陌生的固定表达

    class Meta:
        ordering = ['id']

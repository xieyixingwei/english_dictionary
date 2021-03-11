from django.db import models
from user.models import UserTable
from dictionary.models import SentenceTable
from server.models  import JSONFieldUtf8


class StudySentenceTable(models.Model):
    """
    句子学习表
    """
    id = models.AutoField(primary_key=True)
    foreignUser = models.ForeignKey(to=UserTable, on_delete=models.CASCADE)
    foreignSentence = models.ForeignKey(to=SentenceTable, on_delete=models.CASCADE)
    collect = JSONFieldUtf8()        # 单词本 [a,b]
    familiarity = models.IntegerField() # 0 ~ 5
    repeats = models.IntegerField()
    learnRecord = JSONFieldUtf8() # [09122030,09112030,09102030]
    inplan = models.BooleanField()
    newWords = JSONFieldUtf8()   # 生词 [w1,w2]
    nextSentences = JSONFieldUtf8() # 下个句子id [id1, id2]
    comments = models.CharField(max_length=256)  # markdown

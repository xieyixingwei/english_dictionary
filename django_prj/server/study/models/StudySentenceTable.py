from django.db import models
from user.models import UserTable
from dictionary.models import SentenceTable


class StudySentenceTable(models.Model):
    """
    句子学习表
    """
    ss_id = models.AutoField(primary_key=True)
    ss_user = models.ForeignKey(to=UserTable, on_delete=models.CASCADE)
    ss_sentence = models.ForeignKey(to=SentenceTable, on_delete=models.CASCADE)
    ss_collect = models.JSONField()        # 单词本 [a,b]
    ss_familiarity = models.IntegerField() # 0 ~ 5
    ss_repeats = models.IntegerField()
    ss_learn_record = models.JSONField() # [09122030,09112030,09102030]
    ss_inplan = models.BooleanField()
    ss_new_words = models.JSONField()   # 生词 [w1,w2]
    ss_next_sentences = models.JSONField() # 下个句子id [id1, id2]
    ss_comments = models.CharField(max_length=256)  # markdown

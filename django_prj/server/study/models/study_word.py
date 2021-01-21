from django.db import models
from user.models import User
from dictionary.models import Word


class StudyWord(models.Model):
    """
    单词学习表
    """
    sw_id = models.AutoField(primary_key=True)
    sw_user = models.ForeignKey(to=User, on_delete=models.CASCADE)
    sw_word = models.ForeignKey(to=Word, on_delete=models.CASCADE)
    sw_collect = models.JSONField()        # 单词本 [a,b]
    sw_familiarity = models.IntegerField() # 0 ~ 5
    sw_repeats = models.IntegerField()
    sw_learn_record = models.JSONField() # [09122030,09112030,09102030]
    sw_inplan = models.BooleanField()
    sw_comments = models.CharField(max_length=256) # markdown
    class Meta:
        db_table = "study_word"

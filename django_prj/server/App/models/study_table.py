from django.db import models
from .user_table import User
from .word_table import Word
from .sentence_table import Sentence
from .grammer_table import Grammar


class StudyPlan(models.Model):
    """
    学习计划表
    """
    sp_id = models.AutoField(primary_key=True)
    sp_user = models.ForeignKey(to=User, on_delete=models.CASCADE)
    sp_once_words = models.IntegerField()
    sp_once_sentences = models.IntegerField()
    sp_once_grammers = models.IntegerField()
    sp_other_settings = models.JSONField()
    class Meta:
        db_table = "StudyPlan"


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
    sw_comments = models.TextField()  # markdown
    class Meta:
        db_table = "StudyWord"


class StudySentence(models.Model):
    """
    句子学习表
    """
    ss_id = models.AutoField(primary_key=True)
    ss_user = models.ForeignKey(to=User, on_delete=models.CASCADE)
    ss_sentence = models.ForeignKey(to=Sentence, on_delete=models.CASCADE)
    ss_collect = models.JSONField()        # 单词本 [a,b]
    ss_familiarity = models.IntegerField() # 0 ~ 5
    ss_repeats = models.IntegerField()
    ss_learn_record = models.JSONField() # [09122030,09112030,09102030]
    ss_inplan = models.BooleanField()
    ss_new_words = models.JSONField()   # 生词 [w1,w2]
    ss_next_sentences = models.JSONField() # 下个句子id [id1, id2]
    ss_comments = models.TextField()  # markdown
    class Meta:
        db_table = "StudySentence"


class StudyGrammer(models.Model):
    """
    语法学习表
    """
    sg_id = models.AutoField(primary_key=True)
    sg_user = models.ForeignKey(to=User, on_delete=models.CASCADE)
    sg_grammer = models.ForeignKey(to=Grammar, on_delete=models.CASCADE)
    sg_familiarity = models.IntegerField() # 0 ~ 5
    sg_repeats = models.IntegerField()
    sg_learn_record = models.JSONField() # [09122030,09112030,09102030]
    sg_inplan = models.BooleanField()
    sg_comments = models.TextField()  # markdown
    class Meta:
        db_table = "StudyGrammer"

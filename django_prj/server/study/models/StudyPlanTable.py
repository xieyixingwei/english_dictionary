from django.db import models
from user.models import UserTable


class StudyPlanTable(models.Model):
    """
    学习计划表
    """
    sp_id = models.AutoField(primary_key=True)
    sp_user = models.ForeignKey(to=UserTable, on_delete=models.CASCADE)
    sp_once_words = models.IntegerField()
    sp_once_sentences = models.IntegerField()
    sp_once_grammers = models.IntegerField()
    sp_other_settings = models.JSONField()

from django.db import models
from user.models import UserTable
from server.models  import JSONFieldUtf8


class StudyPlanTable(models.Model):
    """
    学习计划表
    """
    id = models.AutoField(primary_key=True)
    foreignUser = models.ForeignKey(to=UserTable, on_delete=models.CASCADE)
    once_words = models.IntegerField()
    onceSentences = models.IntegerField()
    onceGrammers = models.IntegerField()
    otherSettings = JSONFieldUtf8()

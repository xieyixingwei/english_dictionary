from django.db import models


class Grammar(models.Model):
    """
    语法表
    """
    g_id = models.AutoField(primary_key=True)
    g_type = models.JSONField() # [时态,从句]
    g_tags = models.JSONField() # [重要]
    g_content = models.TextField(null=False, blank=True) # 内容 markdown文本
    class Meta:
        db_table = "Grammar"

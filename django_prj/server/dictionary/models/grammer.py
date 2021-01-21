from django.db import models


class Grammar(models.Model):
    """
    语法表
    """
    g_id = models.AutoField(primary_key=True)
    g_type = models.JSONField() # [时态,从句]
    g_tags = models.JSONField() # [重要]
    g_content = models.TextField(null=False, blank=True) # 内容 markdown文本
    g_image = models.ImageField() # 图片讲解
    g_vedio = models.FilePathField(max_length=128) # 视频讲解
    class Meta:
        db_table = "grammar"

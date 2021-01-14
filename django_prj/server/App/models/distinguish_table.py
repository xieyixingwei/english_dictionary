from django.db import models


class Distinguish(models.Model):
    """
    词义辨析表
    """
    d_id = models.AutoField(primary_key=True)
    d_words = models.JSONField()   # 单词列表 [word1,word2,...]
    d_content = models.TextField() # 内容 markdown文本
    class Meta:
        db_table = "Distinguish"

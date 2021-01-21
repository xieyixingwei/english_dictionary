from django.db import models


class Distinguish(models.Model):
    """
    词义辨析表
    """
    d_id = models.AutoField(primary_key=True)
    d_words = models.JSONField()   # 单词列表 [word1,word2,...]
    d_content = models.TextField() # 内容 markdown文本
    d_image = models.ImageField() # 图片讲解
    d_vedio = models.FilePathField(max_length=128) # 视频讲解
    class Meta:
        db_table = "distinguish"

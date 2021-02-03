from django.db import models
from dictionary.models import WordTable


class DistinguishWordTable(models.Model):
    """
    词义辨析表
    """
    d_id = models.AutoField(primary_key=True)
    d_words = models.JSONField(null=True)   # 单词列表 [word1,word2,...]
    d_content = models.TextField(null=True) # 内容 markdown文本
    d_word = models.ManyToManyField(to=WordTable, related_name='distinguish')
    #d_image = models.ImageField(null=True) # 图片讲解
    #d_vedio = models.FilePathField(max_length=128, null=True) # 视频讲解

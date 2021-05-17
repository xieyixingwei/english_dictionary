from django.db import models
from dictionary.models.WordTable import WordTable
from dictionary.models.SentenceTable import SentenceTable


class DistinguishTable(models.Model):
    """
    词义辨析表
    """
    id = models.AutoField(primary_key=True)
    content = models.TextField(null=True, blank=True) # 内容 markdown文本
    image = models.ImageField(upload_to='distinguish_images/', null=True, blank=True, verbose_name="图片讲解") # 图片讲解
    vedio = models.FileField(upload_to='distinguish_videos/', null=True, blank=True, verbose_name="视频讲解") # 视频讲解
    wordsForeign = models.ManyToManyField(to=WordTable, related_name='distinguishSet', blank=True)
    sentencesForeign = models.ManyToManyField(to=SentenceTable, related_name='distinguishSet', blank=True)
    class Meta:
        ordering = ['id']

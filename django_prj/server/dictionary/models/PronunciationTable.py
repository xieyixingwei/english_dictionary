from django.db import models
from server.models  import JSONFieldUtf8


class SoundmarkTable(models.Model):
    """
    音标表
    """
    name = models.CharField(max_length=16, primary_key=True)
    category = JSONFieldUtf8(null=True) # [元音,辅音..]
    content = models.CharField(max_length=128, null=True) # 内容 markdown文本
    example = JSONFieldUtf8(null=True) # [word1, word2..]
    image = models.ImageField(upload_to='soundmark_images/', null=True, blank=True, verbose_name="图片讲解") # 图片
    vedio = models.FileField(upload_to='soundmark_vedios/', null=True, blank=True, verbose_name="视频讲解") # 视频讲解
    #redio = models.FileField(null=True) # 发音
    


class PronunciationTable(models.Model):
    """
    字母(字组)读音表
    """
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=16, null=True)
    content = models.TextField(null=True) # 内容 markdown文本
    example = JSONFieldUtf8(null=True) # [word1, word2..]
    image = models.ImageField(upload_to='pronunciation_images/', null=True, blank=True, verbose_name="图片讲解") # 图片
    vedio = models.FileField(upload_to='pronunciation_vedios/', null=True, blank=True, verbose_name="视频讲解") # 视频讲解
    #s_redio = models.FilePathField(null=True) # 发音

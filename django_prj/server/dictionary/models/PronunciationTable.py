from django.db import models
from server.models  import JSONFieldUtf8


class SoundmarkTable(models.Model):
    """
    音标表
    """
    s_name = models.CharField(max_length=16, primary_key=True)
    s_type = JSONFieldUtf8(null=True) # [元音,辅音..]
    s_content = models.CharField(max_length=128, null=True) # 内容 markdown文本
    s_example = JSONFieldUtf8(null=True) # [word1, word2..]
    s_image = models.ImageField(null=True) # 图片
    #s_redio = models.FilePathField(null=True) # 发音
    #s_vedio = models.FilePathField(max_length=128, null=True) # 视频讲解


class PronunciationTable(models.Model):
    """
    字母(字组)读音表
    """
    p_id = models.AutoField(primary_key=True)
    p_name = models.CharField(max_length=16, null=True)
    p_content = models.TextField(null=True) # 内容 markdown文本
    s_example = JSONFieldUtf8(null=True) # [word1, word2..]
    #p_image = models.ImageField(null=True) # 图片讲解
    #s_redio = models.FilePathField(null=True) # 发音
    #p_vedio = models.FilePathField(max_length=128, null=True) # 视频讲解

from django.db import models


class Soundmark(models.Model):
    """
    音标表
    """
    s_name = models.CharField(max_length=16, primary_key=True)
    s_type = models.JSONField() # [元音,辅音..]
    s_content = models.CharField(max_length=128, null=False, blank=True) # 内容 markdown文本
    s_example = models.JSONField() # [word1, word2..]
    s_image = models.ImageField() # 图片
    s_redio = models.FilePathField() # 发音
    s_vedio = models.FilePathField(max_length=128) # 视频讲解
    class Meta:
        db_table = "soundmark"


class Pronunciation(models.Model):
    """
    字母(字组)读音表
    """
    p_id = models.AutoField(primary_key=True)
    p_name = models.CharField(max_length=16)
    p_content = models.TextField(null=False, blank=True) # 内容 markdown文本
    s_example = models.JSONField() # [word1, word2..]
    p_image = models.ImageField() # 图片讲解
    s_redio = models.FilePathField() # 发音
    p_vedio = models.FilePathField(max_length=128) # 视频讲解
    class Meta:
        db_table = "pronunciation"

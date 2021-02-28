from django.db import models
from dictionary.models import WordTable, SentenceTable


class GrammarTable(models.Model):
    """
    语法表
    """
    g_id = models.AutoField(primary_key=True)
    g_type = models.JSONField(null=True) # [时态,从句]
    g_tags = models.JSONField(null=True) # [重要]
    g_content = models.TextField(null=False, blank=True) # 内容 markdown文本
    g_word = models.ForeignKey(to=WordTable, related_name='word_grammar', null=True, on_delete=models.CASCADE)
    g_sentence = models.ForeignKey(to=SentenceTable, related_name='sentence_grammar', null=True, on_delete=models.CASCADE)
    #g_image = models.ImageField(null=True) # 图片讲解
    #g_vedio = models.FilePathField(max_length=128, null=True) # 视频讲解


class GrammarTypeTable(models.Model):
    """
    语法表的Type
    """
    g_name = models.CharField(primary_key=True, max_length=64) # [时态,从句]


class GrammarTagTable(models.Model):
    """
    语法表的Tags
    """
    g_name = models.CharField(primary_key=True, max_length=64) # [重要]

from django.db import models
from dictionary.models.WordTable import WordTable
from dictionary.models.SentenceTable import SentenceTable
from server.models  import JSONFieldUtf8


class GrammarTable(models.Model):
    """
    语法表
    """
    id = models.AutoField(primary_key=True)
    title = models.CharField(max_length=128, default='')
    type = JSONFieldUtf8(null=True) # [时态,从句]
    tag = JSONFieldUtf8(null=True) # [重要]
    content = models.TextField(null=True) # 内容 markdown文本
    image = models.ImageField(upload_to='grammar_images/', null=True, blank=True, verbose_name="图片讲解") # 图片讲解
    vedio = models.FileField(upload_to='grammar_vedios/', null=True, blank=True, verbose_name="视频讲解") # 视频讲解
    wordForeign = models.ForeignKey(to=WordTable, related_name='grammarSet', null=True, on_delete=models.SET_NULL)
    # on_delete=models.SET_NULL: 当主表项被删除时,从表项不会被删除，但是对应字段被设置为NULL
    sentenceForeign = models.ForeignKey(to=SentenceTable, related_name='grammarSet', null=True, on_delete=models.SET_NULL)
    class Meta:
        ordering = ['id']  # 消除list警告UnorderedObjectListWarning: Pagination may yield inconsistent results with an unordered object_list


class GrammarTypeTable(models.Model):
    """
    语法表的Type
    """
    name = models.CharField(primary_key=True, max_length=64) # [时态,从句]


class GrammarTagTable(models.Model):
    """
    语法表的Tags
    """
    name = models.CharField(primary_key=True, max_length=64) # [重要]

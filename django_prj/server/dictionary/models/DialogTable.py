from django.db import models
from server.models  import JSONFieldUtf8


class DialogTable(models.Model):
    """
    对话表
    """
    id = models.AutoField(primary_key=True)
    title = models.CharField(max_length=64) # 英文
    tag = JSONFieldUtf8(null=True)    # 标记 [日常用语,商务用语]
    dialogSentences = JSONFieldUtf8(null=True)    # 对话例句的id [id, id]
    video = models.FileField(upload_to='dialog_video/', null=True, blank=True, verbose_name="视频")
    class Meta:
        ordering = ['id']  # 消除list警告UnorderedObjectListWarning: Pagination may yield inconsistent results with an unordered object_list


class DialogTagTable(models.Model):
    """
    对话表的Tags
    """
    name = models.CharField(primary_key=True, max_length=64) # [重要]

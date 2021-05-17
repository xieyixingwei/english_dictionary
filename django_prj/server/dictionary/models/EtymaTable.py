from django.db import models


class EtymaTable(models.Model):
    """
    词根词缀表
    """
    name = models.CharField(max_length=32, primary_key=True) # 词根 (primary key)
    interpretation = models.TextField(max_length=512, null=True) # 含义 markdown
    type = models.IntegerField(null=True) # 类型: 前缀|后缀|词根
    image = models.ImageField(upload_to='etyma_images/', null=True, blank=True, verbose_name="图片讲解") # 图片讲解
    vedio = models.FileField(upload_to='etyma_videos/', null=True, blank=True, verbose_name="视频内容") # 视频讲解

    class Meta:
        ordering = ['name']  # 消除list警告UnorderedObjectListWarning: Pagination may yield inconsistent results with an unordered object_list

    @property
    def _type(self) -> str:
        if self.type == 0:
            return "prefix"
        elif self.type == 1:
            return "suffix"
        elif self.type == 2:
            return "etyma"
        else:
            return "unkown"

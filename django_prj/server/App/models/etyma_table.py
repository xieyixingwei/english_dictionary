from django.db import models


class Etyma(models.Model):
    """
    词根词缀表
    """
    e_name = models.CharField(max_length=32, primary_key=True) # 词根 (primary key)
    e_meaning = models.TextField(max_length=512, blank=True) # 含义 markdown
    e_type = models.IntegerField() # 类型: 前缀|后缀|词根
    class Meta:
        db_table = "Etyma"
    def type(self) -> str:
        if self.e_type == 0:
            return "prefix"
        elif self.e_type == 1:
            return "etyma"
        elif self.e_type == 2:
            return "suffix"
        else:
            return "unkown"

from django.db import models
from server.models  import JSONFieldUtf8


class UserTable(models.Model):
    """
    用户表
    """
    id = models.AutoField(primary_key=True)
    uname = models.CharField(max_length=32, unique=True, null=False, blank=False) # 用户名
    passwd = models.CharField(max_length=256, null=False, blank=False) # 密码
    isAdmin = models.BooleanField(default=False) # 是否是管理员
    registerDate = models.DateTimeField(auto_now_add=True) # 注册时间
    name = models.CharField(max_length=32, null=True, blank=True) # 姓名
    gender = models.BooleanField(null=True) # 性别
    birthday = models.DateTimeField(null=True) # 生日
    education = models.IntegerField(null=True) # 学历
    wechart = models.CharField(max_length=64, null=True) # 微信号
    qq = models.CharField(max_length=64, null=True) # QQ号
    email = models.CharField(max_length=64, null=True) # email
    telephone = models.CharField(max_length=16, null=True) # 电话
    status = JSONFieldUtf8(null=True) # 状态

    def _gender(self) -> str:
        return '男' if self.gender else '女'

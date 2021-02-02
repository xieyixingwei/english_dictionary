from django.db import models
from django.contrib.auth.hashers import make_password


class User(models.Model):
    """
    用户表
    """
    u_id = models.AutoField(primary_key=True)
    u_uname = models.CharField(max_length=32, unique=True, null=False, blank=False) # 用户名
    u_passwd = models.CharField(max_length=256, null=False, blank=False) # 密码
    u_is_admin = models.BooleanField(default=False) # 是否是管理员
    u_register_date = models.DateTimeField(auto_now_add=True) # 注册时间
    u_name = models.CharField(max_length=32, null=True, blank=True) # 姓名
    u_gender = models.BooleanField(null=True) # 性别
    u_birthday = models.DateTimeField(null=True) # 生日
    u_education = models.IntegerField(null=True) # 学历
    u_wechart = models.CharField(max_length=64, null=True) # 微信号
    u_qq = models.CharField(max_length=64, null=True) # QQ号
    u_email = models.CharField(max_length=64, null=True) # email
    u_telephone = models.CharField(max_length=16, null=True) # 电话
    u_status = models.JSONField(null=True) # 状态

    class Meta:
        db_table = 'user'

    def gender(self) -> str:
        return '男' if self.u_gender else '女'

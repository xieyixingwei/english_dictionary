from django.db import models


class User(models.Model):
    """
    用户表
    """
    u_id = models.AutoField(primary_key=True)
    u_uname = models.CharField(max_length=32, unique=True, null=False, blank=False) # 用户名
    u_passwd = models.CharField(max_length=128, null=False, blank=False) # 密码
    u_is_admin = models.BooleanField(default=False) # 是否是管理员
    u_register_date = models.DateTimeField(blank=False) # 注册时间
    u_name = models.CharField(max_length=32, blank=True) # 姓名
    u_gender = models.BooleanField(default=False) # 性别
    u_birthday = models.DateTimeField(blank=True) # 生日
    u_education = models.IntegerField(blank=True) # 学历
    u_wechart = models.CharField(max_length=64, blank=True) # 微信号
    u_qq = models.CharField(max_length=64, blank=True) # QQ号
    u_email = models.CharField(max_length=64, blank=True) # email
    u_telephone = models.CharField(max_length=16, blank=True) # 电话
    u_status = models.JSONField() # 状态
    class Meta:
        db_table = "User"

    def gender(self) -> str:
        return "男" if self.u_gender else "女"



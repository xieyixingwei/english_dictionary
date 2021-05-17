from django.db import models


class WordTagTable(models.Model):
    """
    单词 Tags
    """
    name = models.CharField(max_length=32, primary_key=True)

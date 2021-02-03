# Generated by Django 3.1.1 on 2021-02-03 09:33

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('dictionary', '0001_initial'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='distinguishwordtable',
            name='d_word',
        ),
        migrations.AddField(
            model_name='distinguishwordtable',
            name='d_word',
            field=models.ManyToManyField(related_name='distinguish', to='dictionary.WordTable'),
        ),
        migrations.AlterField(
            model_name='grammartable',
            name='g_sentence',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='sentence_grammar', to='dictionary.sentencetable'),
        ),
        migrations.AlterField(
            model_name='grammartable',
            name='g_word',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='word_grammar', to='dictionary.wordtable'),
        ),
    ]
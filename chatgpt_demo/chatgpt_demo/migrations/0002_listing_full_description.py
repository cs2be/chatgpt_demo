# Generated by Django 4.2.4 on 2023-08-23 22:28

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('chatgpt_demo', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='listing',
            name='full_description',
            field=models.TextField(default=''),
        ),
    ]

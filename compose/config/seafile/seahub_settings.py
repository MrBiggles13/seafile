# -*- coding: utf-8 -*-
# sample config
SECRET_KEY = "<your secret key>"
SERVICE_URL = "https://seafile.example.com"

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': '<db_name>',
        'USER': '<db_user>',
        'PASSWORD': '<db_password>',
        'HOST': '<db_hostname>',
        'PORT': '3306',
        'OPTIONS': {'charset': 'utf8mb4'},
    }
}

CACHES = {
    "default": {
        "BACKEND": "django.core.cache.backends.redis.RedisCache",
        "LOCATION": "redis://<redis_host>:6379",
    }
}
COMPRESS_CACHE_BACKEND = 'locmem'
TIME_ZONE = 'Etc/UTC'
FILE_SERVER_ROOT = "https://seafile.example.com/seafhttp"
CSRF_TRUSTED_ORIGINS = ["https://seafile.example.com"]
EMAIL_USE_SSL = True
EMAIL_HOST = 'smtp.example.com'        # smpt server
EMAIL_HOST_USER = 'email@example.com'    # username and domain
EMAIL_HOST_PASSWORD = 'password'    # password
EMAIL_PORT = 465
DEFAULT_FROM_EMAIL = EMAIL_HOST_USER
SERVER_EMAIL = EMAIL_HOST_USER
ENABLE_UPLOAD_LINK_VIRUS_CHECK = True
ADD_REPLY_TO_HEADER = True

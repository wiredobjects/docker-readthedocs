FROM centos:7

ENV PYTHONUNBUFFERED 1
ENV DJANGO_PYTHON=/usr/bin/python3
ENV DJANGO_SETTINGS_MODULE readthedocs.settings.dev
ENV DJANGO_RUNTIME_LISTEN_IP 0.0.0.0
ENV DJANGO_RUNTIME_LISTEN_PORT 8000
ENV DJANGO_RUNTIME_COUNT_WORKERS 3
ENV DJANGO_ADMIN_USER admin
ENV DJANGO_ADMIN_PASS admin
ENV DJANGO_ADMIN_EMAIL admin@example.com

RUN yum -y makecache fast \
  && yum -y install epel-release \
  && yum -y makecache fast \
  && yum -y install git python34 python34-libs python34-setuptools python34-pip python34-devel \
  && cd /tmp \
  && curl -L -O https://github.com/rtfd/readthedocs.org/archive/2.6.1.tar.gz \
  && tar zxf 2.6.1.tar.gz \
  && mv readthedocs.org-2.6.1 /app \
  && cd /app \
  && pip3 install --upgrade pip \
  && pip install -r requirements.txt \
  && pip install gunicorn \
  && python3 manage.py collectstatic --noinput \
  && yum -y erase python34-devel
ADD instance_setup.py /app/readthedocs/core/management/commands/
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod a+x /usr/local/bin/docker-entrypoint.sh \
  && ln -s /usr/local/bin/docker-entrypoint.sh /
WORKDIR /app
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["run"]

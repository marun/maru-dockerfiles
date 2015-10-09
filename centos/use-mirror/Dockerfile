FROM docker.io/centos:latest
MAINTAINER marun@redhat.com

RUN sed -i -e 's+metalink=+#metalink=+' /etc/yum.repos.d/CentOS-Base.repo
RUN sed -i -e 's+#baseurl=+baseurl=+' /etc/yum.repos.d/CentOS-Base.repo
RUN sed -i -e 's+#mirror.centos.org+mirror.hmc.edu+' /etc/yum.repos.d/CentOS-Base.repo

RUN yum clean all

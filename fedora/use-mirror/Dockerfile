FROM docker.io/fedora:22
MAINTAINER marun@redhat.com

RUN echo 'deltarpm=0' >> /etc/dnf/dnf.conf
RUN sed -i -e 's+metalink=+#metalink=+' /etc/yum.repos.d/fedora.repo
RUN sed -i -e 's+#baseurl=.*+baseurl=http://igor:7080/fedora+' \
  /etc/yum.repos.d/fedora.repo
RUN sed -i -e 's+metalink=+#metalink=+' /etc/yum.repos.d/fedora-updates.repo
RUN sed -i -e 's+#baseurl=.*+baseurl=http://igor:7080/updates+' \
  /etc/yum.repos.d/fedora-updates.repo

RUN dnf clean all

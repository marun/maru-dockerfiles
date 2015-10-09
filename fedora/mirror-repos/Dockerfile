FROM fedora:22
MAINTAINER marun@redhat.com

RUN echo 'deltarpm=0' >> /etc/dnf/dnf.conf
RUN sed -i -e 's+#baseurl=+baseurl=+' /etc/yum.repos.d/*.repo
RUN sed -i -e 's+metalink=+#metalink=+' /etc/yum.repos.d/*.repo
RUN sed -i -e 's+download.fedoraproject.org/pub+mirror.hmc.edu+' /etc/yum.repos.d/*.repo

RUN dnf -y install yum-utils createrepo findutils; dnf clean all

ADD sync-yum-mirrors.sh /sync-yum-mirrors.sh

CMD ["/sync-yum-mirrors.sh"]

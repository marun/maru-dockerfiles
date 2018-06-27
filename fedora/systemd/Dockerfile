#
# Container running systemd.
#
# The standard name for this image is maru/systemd
#
# On recent Fedora and CentOS, this image can be run unprivileged
# thanks to oci-systemd-hook:
#
# http://developers.redhat.com/blog/2016/09/13/running-systemd-in-a-non-privileged-container/
#

FROM fedora:28
MAINTAINER marun@redhat.com

# Fix 'WARNING: terminal is not fully functional' when TERM=dumb
ENV TERM=xterm

## Configure systemd to run in a container

ENV container=docker

VOLUME ["/run", "/tmp"]

STOPSIGNAL SIGRTMIN+3

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

RUN systemctl mask\
 auditd.service\
 console-getty.service\
 dev-hugepages.mount\
 dnf-makecache.service\
 docker-storage-setup.service\
 getty.target\
 lvm2-lvmetad.service\
 sys-fs-fuse-connections.mount\
 systemd-logind.service\
 systemd-remount-fs.service\
 systemd-udev-hwdb-update.service\
 systemd-udev-trigger.service\
 systemd-udevd.service\
 systemd-vconsole-setup.service
RUN cp /usr/lib/systemd/system/dbus.service /etc/systemd/system/;\
 sed -i 's/OOMScoreAdjust=-900//' /etc/systemd/system/dbus.service

CMD ["/usr/sbin/init"]

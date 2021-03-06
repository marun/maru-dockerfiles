FROM maru/systemd:fedora31
MAINTAINER marun@redhat.com

ENV DEV_USER dev
ENV DEV_HOME /home/$DEV_USER

# Install sshd
RUN dnf -y update; dnf -y install openssh-server sudo; dnf clean all

# Add non-root user
RUN /usr/sbin/groupadd $DEV_USER
RUN /usr/sbin/useradd $DEV_USER -g $DEV_USER -d $DEV_HOME --create-home --shell /bin/bash
RUN echo "${DEV_USER}:${DEV_USER}" | chpasswd

# Install authorized keys
RUN mkdir $DEV_HOME/.ssh
ADD authorized_keys $DEV_HOME/.ssh/authorized_keys
RUN chown -R $DEV_USER:$DEV_USER $DEV_HOME/.ssh
RUN chmod 600 $DEV_HOME/.ssh/authorized_keys
RUN chmod 700 $DEV_HOME/.ssh

# Configure sudo
RUN cp /etc/sudoers /etc/sudoers.orig
RUN echo "${DEV_USER}        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
RUN sed -i -e '/Defaults\s\+env_reset/a Defaults\tenv_keep += "SSH_AUTH_SOCK"' /etc/sudoers

EXPOSE 22

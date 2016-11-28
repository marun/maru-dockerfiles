# Base image for development environment.

FROM maru/sshd
MAINTAINER marun@redhat.com

# Install packages
RUN dnf -y update && dnf -y install\
 ack\
 aspell-en\
 aspell\
 bash-completion\
 bind-utils\
 docker\
 emacs-nox\
 findutils\
 fpaste\
 gcc-c++\
 gcc\
 git\
 htop\
 libxml2-devel\
 libxslt-devel\
 links\
 make\
 mercurial\
 procps\
 python-devel\
 screen\
 stow\
 sysstat\
 vim-enhanced\
 && dnf clean all

# Install upstream golang until 1.7 is available in f24.
ENV GO_ARCHIVE go1.7.3.linux-amd64.tar.gz
RUN curl -o /tmp/${GO_ARCHIVE}\
 https://storage.googleapis.com/golang/${GO_ARCHIVE};\
 tar -C /usr/local -xzf /tmp/${GO_ARCHIVE}

# Configure ssh to accept git config
RUN echo 'AcceptEnv GIT_AUTHOR_*' >> /etc/ssh/sshd_config
RUN echo 'AcceptEnv GIT_COMMITTER_*' >> /etc/ssh/sshd_config

# Configure ssh to accept TZ
RUN echo 'AcceptEnv TZ' >> /etc/ssh/sshd_config

# Need this path for the build but it is intended to be mounted as a volume
RUN mkdir /opt/src
RUN chown dev:dev /opt/src

# Ensure that the user belongs to the group owning the docker socket
# on the host.
# TODO - discover the gid of the docker group on the host
RUN groupadd --gid 1001 docker-socket
RUN usermod -a -G docker-socket dev

USER $DEV_USER

ENV SRC_DIR "/home/${DEV_USER}/src"

RUN ln -sf /opt/src "${SRC_DIR}"

# Configure dotfiles
RUN git clone https://github.com/marun/dotfiles.git "${SRC_DIR}/dotfiles"
RUN ${SRC_DIR}/dotfiles/apply.sh

# Configure binfiles
RUN git clone https://github.com/marun/binfiles.git "${SRC_DIR}/binfiles"
RUN ln -sf "${SRC_DIR}/binfiles" "${HOME}/bin"

# Configure emacs.  Install needs to run post-build to allow the install to
# update the mounted path.
RUN ln -sf "${SRC_DIR}/dot-emacs" "${HOME}/.emacs.d"

USER root

# Clear source path (intended to be mounted as a volume)
RUN rm -rf /opt/src/*

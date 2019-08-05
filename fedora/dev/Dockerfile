# Base image for development environment.

FROM maru/sshd:fedora30
MAINTAINER marun@redhat.com

# Remove nodocs option from dnf config
RUN sed -i -e '/tsflags=/d' /etc/dnf/dnf.conf

# Install packages
RUN dnf -y update && dnf -y install\
 ack\
 aspell-en\
 aspell\
 bash-completion\
 bind-utils\
 dnf-plugins-core\
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
 man\
 man-pages\
 mercurial\
 procps\
 python-devel\
 rsync\
 screen\
 stow\
 sysstat\
 vim-enhanced\
 && dnf clean all

# Install bazel
RUN dnf copr enable -y vbatts/bazel\
 && dnf -y update\
 && dnf -y install bazel\
 && dnf clean all

# Configure ssh to accept git config
RUN echo 'AcceptEnv GIT_AUTHOR_*' >> /etc/ssh/sshd_config
RUN echo 'AcceptEnv GIT_COMMITTER_*' >> /etc/ssh/sshd_config

# Configure ssh to accept TZ
RUN echo 'AcceptEnv TZ' >> /etc/ssh/sshd_config

# Need this path for the build but it is intended to be mounted as a volume
RUN mkdir /opt/src
RUN chown ${DEV_USER}:${DEV_USER} /opt/src

# Ensure that the user belongs to the group owning the docker socket
# on the host.
# TODO - discover the gid of the docker group on the host
RUN groupadd --gid 1001 docker-socket
RUN usermod -a -G docker-socket ${DEV_USER}

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

# Install gimme
RUN curl -sL -o ~/bin/gimme https://raw.githubusercontent.com/travis-ci/gimme/5256888df1e749fdb6acabc8f9e07a52f05b9f28/gimme
RUN chmod +x ~/bin/gimme

# Install delve
RUN eval $(~/bin/gimme 1.10.3)\
 && GOPATH="/home/${DEV_USER}/go" go get github.com/derekparker/delve/cmd/dlv

USER root

# Clear source path (intended to be mounted as a volume)
RUN rm -rf /opt/src/*

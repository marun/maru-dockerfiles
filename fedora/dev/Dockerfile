# Base image for development environment.  ansible is used to perform
# host-local configuration.

FROM marun/sshd
MAINTAINER marun@redhat.com

# Install packages
RUN dnf -y update && dnf -y install\
 # ansible
 python python-dnf libselinux-python yum-utils\
 # dev
 ack\
 aspell-en\
 aspell\
 emacs-nox\
 findutils\
 gcc-c++\
 gcc\
 git\
 go\
 htop\
 libxml2-devel\
 libxslt-devel\
 links\
 mercurial\
 procps\
 python-devel\
 vim-enhanced\
 && dnf clean all

# Install upstream docker until 1.10 is available in fedora
ADD docker.repo /etc/yum.repos.d/docker.repo
RUN dnf -y install docker-engine && dnf clean all

# Configure ssh
RUN echo 'AcceptEnv GIT_*' >> /etc/ssh/sshd_config

# Need to disable ssh daemon from starting or ansible provisioning
# will try to use ssh instead of docker connection.
ENTRYPOINT []

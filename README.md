# maru-dockerfiles

Tired of waiting for package installation during image builds?  Use a local mirror!

This repo contains configuration specific to my environment, but with a little tweaking it can work for yours, too.

- fedora/mirror-repos
  - Mirror standard repos for fedora 23 to local storage.
- fedora/serve-mirror
  - Serve a local mirror via http (since it's not possible to mount a volume during image build).
- fedora/use-mirror
  - Create a new base image tagged 'fedora:latest' with yum repo configuration pointing to the local mirror.  It will be used for builds that don't explicitly specify 'FROM docker.io/fedora:latest'.
- centos/use-mirror
  - Create a new base image tagged 'centos:latest' with yum configuration pointing to a mirror that is fast for me.  CentOS package download is reliable enough for me that I don't see the point of creating a local mirror.

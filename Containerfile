FROM quay.io/toolbx/arch-toolbox:latest

LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="A cloud-native terminal experience" \
      maintainer="jorge.castro@gmail.com"

COPY extra-packages remove-pacakges /
RUN pacman-key --init && pacman-key --populate archlinux && \pacman --noconfirm -Syyu && \
      grep -v '^#' /remove-packages | xargs pacman --noconfirm -Rs && \
      grep -v '^#' /extra-packages | xargs pacman --noconfirm -S
RUN rm /extra-packages

RUN   ln -fs /bin/sh /usr/bin/sh && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/docker && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/flatpak && \ 
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/podman && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/rpm-ostree && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/transactional-update


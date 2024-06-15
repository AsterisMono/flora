FROM ghcr.io/ublue-os/arch-distrobox:latest

LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="A cloud-native terminal experience" \
      maintainer="cmiki@amono.me"

COPY extra-packages remove-packages /
RUN pacman --noconfirm -Syyu && \
      grep -v '^#' /remove-packages | xargs pacman --noconfirm -Rs && \
      grep -v '^#' /extra-packages | xargs pacman --noconfirm -S
RUN rm /extra-packages /remove-packages

RUN ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/docker && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/flatpak && \ 
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/podman && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/rpm-ostree && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/transactional-update
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/distrobox


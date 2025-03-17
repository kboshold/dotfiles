FROM mcr.microsoft.com/vscode/devcontainers/base:ubuntu

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV DOTFIILES_AUTOINSTALL true
ENV CODESPACES "true"
ENV USER $USERNAME
ENV HOME "/home/$USERNAME"

# Graceful user/group creation with conflict resolution
RUN apt-get update -y && \
    apt-get upgrade -y && \
    rm -rf /var/lib/apt/lists/*

USER $USERNAME
WORKDIR /home/$USERNAME

COPY --chown=$USERNAME:$USERNAME . .

RUN ./install.sh

ENV DOTFILES_INSTALLED="true"
WORKDIR /workspaces


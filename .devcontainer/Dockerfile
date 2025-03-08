FROM mcr.microsoft.com/vscode/devcontainers/base:ubuntu

ARG USERNAME=codespace
ARG USER_UID=1001
ARG USER_GID=$USER_UID

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    sudo=* \
    git=* && \
    rm -rf /var/lib/apt/lists/* && \
    groupadd --gid $USER_GID $USERNAME && \
    useradd --uid $USER_UID --gid $USER_GID -m $USERNAME && \
    echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME
WORKDIR /opt/dotfiles

COPY . .

ENV CODESPACES "true"
ENV USER $USERNAME
ENV HOME "/home/$USERNAME"
RUN ./install.sh && ./install.sh

ENV DOTFILES_INSTALLED="true"

# Set the working directory
WORKDIR /workspace

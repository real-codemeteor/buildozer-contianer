FROM ubuntu:24.04 AS buildozer

ENV USER="user"
ENV HOME_DIR="/home/${USER}"
ENV WORK_DIR="${HOME_DIR}/hostcwd" \
    SRC_DIR="${HOME_DIR}/src" \
    PATH="${HOME_DIR}/.local/bin:${HOME_DIR}/.cargo/bin:${PATH}"

# Configure locale
RUN apt update -qq > /dev/null \
    && DEBIAN_FRONTEND=noninteractive apt install -qq --yes --no-install-recommends \
    locales && \
    locale-gen en_US.UTF-8
ENV LANG="en_US.UTF-8" \
    LANGUAGE="en_US.UTF-8" \
    LC_ALL="en_US.UTF-8"

RUN apt update
RUN apt install -y software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt update
RUN apt dist-upgrade -y
RUN apt remove -y python3.12 python3.12-venv
RUN apt install -y git zip unzip openjdk-17-jdk python3-pip \
    python3-virtualenv autoconf libtool pkg-config zlib1g-dev \
    libncurses5-dev libncursesw5-dev libtinfo6 cmake libffi-dev \
    libssl-dev automake autopoint gettext \
    python3.14 python3.14-venv python3.14-dev \
    sudo

RUN mkdir -p ${HOME_DIR} \
    && python3.14 -m venv ${HOME_DIR}/.venv

WORKDIR ${WORK_DIR}
RUN mkdir src

RUN curl https://sh.rustup.rs >> rustup.sh
RUN chmod +x rustup.sh
RUN ./rustup.sh -y
RUN rm rustup.sh

ENV VIRTUAL_ENV=${HOME_DIR}/.venv
ENV PATH="${VIRTUAL_ENV}/bin:${PATH}"

RUN python3.14 -m pip install -U setuptools && \
    python3.14 -m pip install -U git+https://github.com/kivy/buildozer && \
    python3.14 -m pip install -U legacy-cgi cython==0.29.34

COPY --chmod=755 entrypoint.sh /usr/local/bin/entrypoint.sh

WORKDIR ${HOME_DIR}/hostcwd

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

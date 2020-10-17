FROM ubuntu:20.10

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y git gdb gcc-10 g++-10 htop man unzip vim wget build-essential zlib1g-dev \
    libssl-dev ccache doxygen cppcheck clang clang-format libsasl2-dev liblz4-dev python3.8 \
    autoconf libmbedtls-dev libsystemd-dev libtool autotools-dev libicu-dev libbz2-dev uuid-dev libonig-dev \
    && rm -rf /var/lib/apt/lists/*

ENV CMAKE_VERSION=3.17.2
ENV CMAKE_DIR=3.17
RUN wget -qO- "https://cmake.org/files/v${CMAKE_DIR}/cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz" | tar --strip-components=1 -xz -C /usr/local

RUN useradd --uid 1000 -m user

ENV HOME /home/user
WORKDIR /home/user

CMD ["bash"]

#sudo docker build -f ./docker/Dockerfile -t="ubuntu:external" .
#sudo docker run -it -v /home/rajendra/CLionProjects/coindcx/external:/home/user/external ubuntu:external bash
#cmake -DCMAKE_BUILD_TYPE=Debug ..
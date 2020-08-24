FROM ubuntu:19.10

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y git gdb gcc-9 g++-9 htop man unzip vim wget build-essential zlib1g-dev \
    libssl-dev ccache doxygen cppcheck clang clang-format libsasl2-dev liblz4-dev python3.7-dev \
    && rm -rf /var/lib/apt/lists/*

ENV CMAKE_VERSION=3.17.2
ENV CMAKE_DIR=3.17
RUN wget -qO- "https://cmake.org/files/v${CMAKE_DIR}/cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz" | tar --strip-components=1 -xz -C /usr/local

RUN useradd --uid 1000 -m user

ENV HOME /home/user
WORKDIR /home/user

CMD ["bash"]

#sudo docker build -f ./docker/Dockerfile -t="ubuntu:external" .
#sudo docker run -it -v /home/rajendra/CLionProjects/browserstack/external:/home/user/external ubuntu:external bash
#cmake -DCMAKE_BUILD_TYPE=Debug ..
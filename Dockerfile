FROM ubuntu:22.04

# Install the necessary packages

RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    cmake \
    ninja-build \
    curl \
    libsodium23 \
    libopus0 \
    libssl-dev
RUN curl -o /tmp/dpp.deb https://dl.dpp.dev/latest/linux-x64/deb
RUN dpkg -i /tmp/dpp.deb

COPY . /src

WORKDIR /src

RUN cmake -B build -G Ninja -DCMAKE_BUILD_TYPE=Release

RUN cmake --build build && ls -la build

RUN mkdir -p /app

RUN mv /src/build/FDR /app/FDR

RUN rm -rf /src

WORKDIR /app

VOLUME [ "/app/config.cfg" ]

CMD ["./FDR"]
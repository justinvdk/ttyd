FROM ubuntu:20.04 as base

ARG TARGETARCH

# Dependencies
RUN apt-get update && apt-get install -y --no-install-recommends tini libjson-c-dev libwebsockets-dev && rm -rf /var/lib/apt/lists/*

FROM base as builder

RUN apt-get update && apt-get install -y --no-install-recommends build-essential cmake git && rm -rf /var/lib/apt/lists/*

COPY ./src /ttyd/src
COPY ./CMakeLists.txt /ttyd

WORKDIR /ttyd

RUN mkdir build && cd build && cmake .. && make

FROM base

# Application
COPY --from=builder /ttyd/build/ttyd /usr/bin/ttyd

EXPOSE 7681
WORKDIR /root

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["ttyd", "-W", "bash"]

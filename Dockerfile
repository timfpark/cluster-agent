FROM rust:1.52 as build

COPY ./ ./

RUN cargo build --release

RUN mkdir -p /build
RUN cp target/release/cluster-agent /build/

FROM ubuntu:18.04

RUN apt-get update && apt-get -y upgrade && apt-get -y install openssl
RUN update-ca-certificates -f

COPY --from=build /build/cluster-agent /

CMD ["/cluster-agent"]

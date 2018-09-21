FROM ubuntu:16.04

RUN set -ex

RUN apt-get update && \
    apt-get --no-install-recommends --yes install ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt

COPY ./magic-mani-1.0.1/* /usr/local/bin/

# Contains the blockchain
VOLUME /root/.lokid

# Generate your wallet via accessing the container and run:
# cd /wallet
# loki-wallet-cli
VOLUME /wallet

EXPOSE 18080
EXPOSE 18081

ENTRYPOINT ["lokid", "--p2p-bind-ip=0.0.0.0", "--p2p-bind-port=18080", "--rpc-bind-ip=0.0.0.0", "--rpc-bind-port=18081", "--non-interactive", "--confirm-external-bind"]

FROM debian:buster

EXPOSE 8332
EXPOSE 8333

COPY ./logrotate/bitcoind /etc/logrotate.d/

RUN apt-get update && apt-get -qy install logrotate

RUN cp /etc/cron.daily/logrotate /etc/cron.hourly/

RUN apt-get update && apt-get -qy install wget

RUN wget https://bitcoin.org/bin/bitcoin-core-0.17.0.1/bitcoin-0.17.0.1-x86_64-linux-gnu.tar.gz \
    && tar xzf bitcoin-0.17.0.1-x86_64-linux-gnu.tar.gz \
    && install -m 0755 -o root -g root -t  /usr/local/bin bitcoin-0.17.0/bin/*

RUN mkdir /project

WORKDIR /project

COPY . .

RUN chown -R root .

CMD ["bitcoind", "-datadir=/data", "-prune=551", "-server", "-rpcuser=$RPC_USER", "-rpcpassword=$RPC_PASSWORD", "-rpcallowip=$RPC_ALLOWED_IP"]

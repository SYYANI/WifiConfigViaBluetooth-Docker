FROM debian:buster

ADD sources.list /etc/apt
RUN apt-get update \
&& apt-get dist-upgrade -y \
&& apt-get -y install nano \
&& apt-get -y install expect \
&& apt-get -y install python3 \
&& apt-get -y install wpasupplicant \
&& apt-get -y install bluetooth libbluetooth-dev \
&& apt-get -y install python3-pip \
&& pip3 install wifi \
&& pip3 install python-wifi \
&& pip3 install pybluez \
&& apt-get -y install wireless-tools \
&& apt-get -y install net-tools \

COPY WifiConfigViaBluetooth WifiConfigViaBluetooth
COPY wpa.conf /etc/wpa_supplicant/wpa_supplicant.conf
COPY by-uuid by-uuid

RUN apt-get -y install procps \
&& apt-get install -y strace

#main script PID 1
CMD /bin/bash /start.sh

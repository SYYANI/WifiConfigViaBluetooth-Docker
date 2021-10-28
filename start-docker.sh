apt-get update &&
curl -sSL https://get.docker.com | sh &&
sudo usermod -aG docker pi &&
sudo apt-get install -y libffi-dev libssl-dev &&
sudo apt-get install -y python3 python3-pip &&
sudo apt-get remove  -y python-configparser &&
sudo pip3 -v install  docker-compose &&
sudo systemctl disable bluetooth &&
sudo systemctl stop bluetooth &&
sudo systemctl mask bluetooth.service &&
(echo "#custom_start
interface wlan0
        nohook wpa_supplicant
#custom_end" && cat /etc/dhcpcd.conf) > filename1 && mv filename1 /etc/dhcpcd.conf &&
sudo systemctl restart dhcpcd &&
sudo systemctl disable wpa_supplicant &&
sudo systemctl stop wpa_supplicant &&
rfkill unblock all &&
cd /home &&
git clone https://gitee.com/syyan/aicare.git &&
cd WifiConfigViaBluetooth-Docker &&
docker build -t aicare/wifioverbt:1.0 . &&

#docker-compose up -d

docker run -d \
  --restart=always \
  --name=aicare/wifi_over_bt \
  --volume "/home/aicare/service:/etc/systemd/system/dbus-org.bluez.service:ro" \
  --volume "/home/aicare/start.sh:/start.sh" \
  --device "/dev/wlan0:/dev/wlan0" \
  --net=host \
  --privileged \
  registry.cn-shanghai.aliyuncs.com/aicare/softether
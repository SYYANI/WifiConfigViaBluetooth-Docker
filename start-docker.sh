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
cd ~/Desktop &&
git clone https://gitee.com/syyan/WifiConfigViaBluetooth-Docker.git &&
cd WifiConfigViaBluetooth-Docker &&
docker build -t aicare/wifioverbt:1.0 . &&
docker-compose up -d
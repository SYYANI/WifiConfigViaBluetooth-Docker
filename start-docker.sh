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

docker run -d \
  --restart=always \
  --name=wifioverbt \
  --volume "/home/aicare/service:/etc/systemd/system/dbus-org.bluez.service:ro" \
  --volume "/home/aicare/start.sh:/start.sh" \
  --device "/dev/wlan0:/dev/wlan0" \
  --net=host \
  --privileged \
  registry.cn-shanghai.aliyuncs.com/aicare/wifi_over_bt:1.0
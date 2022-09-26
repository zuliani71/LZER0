download the following files into LZER0 /usr/bin:
– lzer0_hb
– lzer0_shutdown
check they are executable

download the following files into LZER0 /lib/systemd/system/
- lzer0_hb.service
– lzer0_shutdown.service

finally, on LZER0, run:
sudo systemctl enable lzer0_shutdown.service pi@raspberrypi:/lib/systemd/system
sudo systemctl enable lzer0_hb.service

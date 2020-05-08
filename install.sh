sudo cp apcupsd-discord.service /etc/systemd/system/apcupsd-discord.service
sudo cp apcupsd-discord.timer /etc/systemd/system/apcupsd-discord.timer
sudo systemctl daemon-reload
sudo systemctl enable apcupsd-discord.service
sudo systemctl start apcupsd-discord.timer

sudo apt-get update
sudo apt-get -y install build-essential python3-pip 
pip3 install -r requirements.txt

sudo cp bipolarbot.service /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl restart bipolarbot
sudo sytemctl status bipolarbot

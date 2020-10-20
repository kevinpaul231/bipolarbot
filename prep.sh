sudo apt-get update
sudo apt-get -y install build-essential python3-pip
cd /
git clone git@github.com:kevinpaul231/bipolarbot.git
cd bipolarbot 
pip3 install -r app/requirements.txt
sudo useradd bipolarbot --no-create-home
sudo chown -R bipolarbot:bipolarbot app 
sudo cp bipolarbot.service /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl restart bipolarbot
sudo sytemctl status bipolarbot

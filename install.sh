#!/bin/bash
apt-get update && apt-get install python3-venv python3-pip git ffmpeg curl ufw -y
ufw allow 5000/tcp && ufw reload
rm -rf /root/KeiBot
git clone "https://github.com/keibotofficial/keibot-studio.git" /root/KeiBot
cd /root/KeiBot
python3 -m venv venv && source venv/bin/activate
pip install flask google-auth google-auth-oauthlib google-api-python-client librosa opencv-python-headless imageio imageio-ffmpeg numpy
cat <<EOF > /etc/systemd/system/keibot.service
[Unit]
Description=KeiBot Automation Studio
After=network.target

[Service]
User=root
WorkingDirectory=/root/KeiBot
Environment="PATH=/root/KeiBot/venv/bin"
ExecStart=/root/KeiBot/venv/bin/python app.py
Restart=always

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload && systemctl enable keibot && systemctl restart keibot
echo -e "\n\n✅ INSTALASI SELESAI! Web Studio Anda siap di: http://$(curl -s ifconfig.me):5000\n"
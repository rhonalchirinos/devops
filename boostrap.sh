
sudo apt-get update 
sudo apt-get install git ca-certificates curl gnupg -y

if ! which npm  > /dev/null 2>&1; then

  sudo mkdir -p /etc/apt/keyrings
  curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
  echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_18.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list

  sudo apt-get update
  sudo apt-get install nodejs -y

  npm install pm2 -g

  sudo git clone https://github.com/rhonalchirinos/devops_hapi.git
  cd devops_hapi && npm ci && pm2 start index.js

  sudo cp /vagrant/config/default /etc/nginx/sites-available/default --force
  sudo ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/ --force

  # sudo ufw allow 'Nginx Full'
  # sudo systemctl restart nginx
fi

if which nginx > /dev/null 2>&1; then
	sudo apt-get remove --purge nginx -y
	sudo apt-get  autoremove -y
fi

if which pm2 > /dev/null 2>&1; then
	pm2 kill
	npm uninstall pm2
	sudo npm remove pm2 -g
fi

if ! which docker > /dev/null 2>&1; then
	sudo apt-get update
	sudo apt-get install curl gnupg ca-certificates software-properties-common apt-transport-https ca-certificates lsb-release -y
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list &gt; /dev/null
	sudo apt-get update
	sudo apt install docker-ce docker-compose -y
	sudo gpasswd -a vagrant docker
	newgrp docker
fi

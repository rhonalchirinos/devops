
sudo apt-get update 
sudo apt-get install -y nginx git ca-certificates curl gnupg

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

sudo ufw allow 'Nginx Full'
sudo systemctl restart nginx
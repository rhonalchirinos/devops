
if ! grep "192.168.100.20" /etc/hosts > /dev/null; then
  sudo sh -c 'echo "192.168.100.20 puppet.devops2.dev devop" >> /etc/hosts';
fi

if ! which puppetserver > /dev/null 2>&1; then

  sudo wget https://apt.puppetlabs.com/puppet8-release-jammy.deb
  sudo dpkg -i puppet8-release-jammy.deb

  sudo rm -rf puppet8-release-jammy.deb

  sudo apt-get update -y
  sudo apt-get install puppetserver libyaml-dev -y 

  sudo mkdir /opt/puppetlabs/temp
  sudo chmod 1777 /opt/puppetlabs/temp

  sudo systemctl start puppetserver
  sudo systemctl enable puppetserver


  sudo puppetserver ca generate --ca-client --certname puppet.devops.dev

fi

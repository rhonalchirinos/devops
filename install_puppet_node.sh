

if ! grep "192.168.100.10" /etc/hosts > /dev/null; then
  sudo sh -c 'echo "192.168.100.10 puppet.devops.dev devop" >> /etc/hosts';
fi

if ! which puppet  > /dev/null 2>&1; then

  sudo wget https://apt.puppetlabs.com/puppet8-release-jammy.deb
  sudo dpkg -i puppet8-release-jammy.deb
  sudo rm -rf puppet8-release-jammy.deb

  sudo apt-get update -y
  sudo apt-get install puppet-agent -y 

  sudo systemctl start puppet
  sudo systemctl enable puppet
fi

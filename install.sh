#!/bin/sh
set -e

# curl -fsSL https://motd.accelf.net/ | sh

do_install() {
  echo "Starting custom motd installation"

  echo "Disable motd-news"
  sudo sed -i -e 's/ENABLED=1/ENABLED=0/g' /etc/default/motd-news

  echo "Disable other annoying messages"
  if [ -e /etc/update-motd.d/10-help-text ]; then
    sudo chmod -x /etc/update-motd.d/10-help-text
  fi
  if [ -e /etc/update-motd.d/80-livepatch ]; then
    sudo chmod -x /etc/update-motd.d/80-livepatch
  fi
  if [ -e /etc/update-motd.d/91-release-upgrade ]; then
    sudo chmod -x /etc/update-motd.d/91-release-upgrade
  fi

  echo "Setup server infomation"
  echo "Please provide the information of this server"
  read -p "Host Name [$HOSTNAME]: " HOST < /dev/tty
  export HOST="${HOST:-$HOSTNAME}"
  read -p "Location: " LOCATION < /dev/tty
  export LOCATION="$LOCATION"
  read -p "Purpose: " PURPOSE < /dev/tty
  export PURPOSE="$PURPOSE"
  curl -fsSL https://motd.accelf.net/85-server-info.sh | envsubst | sudo tee /etc/update-motd.d/85-server-info > /dev/null
  sudo chmod +x /etc/update-motd.d/85-server-info

  echo "DONE!"
}

do_install

#!/bin/sh
set -e

# curl -fsSL https://motd.accelf.net/ | sh

do_install() {
  echo "Starting custom motd installation"
  echo "Disable motd-news"
  sudo sed -ie 's/ENABLED=1/ENABLED=0/g' /etc/default/motd-news
  echo "Disable other annoying messages"
  sudo chmod -x /etc/update-motd.d/10-help-text /etc/update-motd.d/80-livepatch /etc/update-motd.d/91-release-upgrade
  echo "Setup server infomation"
  sudo curl -fsSL https://motd.accelf.net/85-server-info.sh -o /etc/update-motd.d/85-server-info.sh
  sudo chmod +x /etc/update-motd.d/85-server-info.sh
  echo "Finally edit server infomation by yourself"
  sudo vi /etc/update-motd.d/85-server-info.sh
  echo "DONE!"
}

do_install

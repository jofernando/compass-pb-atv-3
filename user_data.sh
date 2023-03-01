#!/bin/bash
yum update --assumeyes
yum install --assumeyes docker
systemctl enable --now docker

DOCKER_CONFIG=/usr/local/lib/docker
mkdir --parents $DOCKER_CONFIG/cli-plugins
curl --location https://github.com/docker/compose/releases/download/v2.16.0/docker-compose-linux-x86_64 --output $DOCKER_CONFIG/cli-plugins/docker-compose
chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose

usermod --append --groups docker ec2-user

cd /root/
git clone https://github.com/jofernando/compass-pb-atv-3.git
cd compass-pb-atv-3

mkdir --parents /efs/
cat etc/fstab >> /etc/fstab

/bin/cp etc/profile.d/00-aliases.sh /etc/profile.d/00-aliases.sh

docker compose up --detach
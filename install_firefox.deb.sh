#!/bin/bash

# Remove a instalacao anterior do Firefox via snap
sudo snap remove --purge firefox

# Remove o pacote fake que redireciona para o snap
sudo apt remove firefox

# Adiciona o repositorio PPA do Mozilla Team
sudo add-apt-repository ppa:mozillateam/ppa

# Adiciona configuracoes para priorizar a instalacao via PPA
sudo tee /etc/apt/preferences.d/mozillateamppa <<EOF
# Definindo Prioridade Alta
Package: firefox* 
Pin: release o=LP-PPA-mozillateam 
Pin-Priority: 501

# Bloqueando firefox snap no repositorio do Ubuntu
Package: firefox* 
Pin: release o=Ubuntu
Pin-Priority: -1
EOF

# Configura atualizacoes automaticas
echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox

# Atualiza repositorios e instala o Firefox
sudo apt update && sudo apt install firefox


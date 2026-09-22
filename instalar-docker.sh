#!/bin/bash

# Elimina versiones antiguas de Docker
sudo apt-get remove -y docker docker-engine docker.io containerd runc

# Actualiza paquetes del sistema
sudo apt-get update

# Actualiza el sistema
sudo apt-get upgrade -y

# Instala dependencias necesarias
sudo apt-get install -y ca-certificates curl gnupg lsb-release

# Crea carpeta para la clave GPG de Docker
sudo mkdir -p /etc/apt/keyrings

# Descarga la clave GPG oficial de Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Agrega el repositorio oficial de Docker a las fuentes del sistema
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Actualiza los repositorios con el nuevo repositorio de Docker
sudo apt-get update

# Instala Docker y Docker Compose
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Comprueba la instalación de Docker con un contenedor de prueba
sudo docker run hello-world

# Agrega el usuario al grupo 'docker' para usar Docker sin sudo
sudo usermod -aG docker $USER

echo "Instalación finalizada. Cerrá sesión o ejecutá 'newgrp docker' para usar Docker sin sudo."
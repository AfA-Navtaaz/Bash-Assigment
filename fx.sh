#!/bin/bash

# Load properties file
source config.properties

# Install GIT
if ( "$install_git" == "true" ); then
     echo "Installing GIT"
     sudo apt-get update &&  sudo apt-get install git -y
fi

# Install Localstack
if [ "$install_localstack" == "true" ]; then
    echo "Installing Localstack"
    sudo apt install python3-pip -y
    sudo pip3 install localstack
fi

# Install Java with specific version
if [ "$install_java" == "true" ]; then
     echo "Installing JAVA"
     sudo apt-get update &&  sudo apt-get install openjdk-$java_version -y
fi

# Install Maven
if [ "$install_maven" == "true" ]; then
     echo "Installing Maven"
     sudo apt-get update &&  sudo apt-get install maven -y
fi

# Install Eclipse
if [ "$install_eclipse" == "true" ]; then
    echo "Installing Eclipse"
    sudo apt-get install snapd
    sudo snap install --classic eclipse
fi

# Install IntelliJ
if [ "$install_intellij" == "true" ]; then
    echo "Installing IntelliJ"
    sudo snap install intellij-idea-community --classic
fi

# Install Docker
if [ "$install_docker" == "true" ]; then
    echo "Installing Docker"
    sudo apt-get update
    sudo apt-get install -y docker.io
    sudo systemctl enable --now docker
    sudo usermod -aG docker "$USER"
fi

# Install MySQL
if [ "$install_mysql" == "true" ]; then
     echo "Installing MYSQL"
     sudo apt-get update &&  sudo apt-get install mysql-server -y
fi

# Set up environment variables
echo "export JAVA_HOME=/usr/lib/jvm/java-$java_version-openjdk-amd64" >> ~/.bashrc
echo "export M2_HOME=/usr/share/maven" >> ~/.bashrc
echo "export MAVEN_HOME=/usr/share/maven" >> ~/.bashrc
echo "export PATH=\$PATH:\$M2_HOME/bin" >> ~/.bashrc

# Set up user accounts and permissions
sudo useradd -m $new_user
sudo usermod -aG sudo $new_user

echo "Installation complete"

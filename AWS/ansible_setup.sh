#!/bin/bash
sudo apt update -y 
sudo apt upgrade -y 
sudo apt install -y git unzip python3 python3-boto3 python3-boto python3-pip
sudo yes | pip install ansible
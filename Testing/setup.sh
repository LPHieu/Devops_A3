# RMIT University Vietnam
# Course: COSC2767 Systems Deployment and Operations
# Semester: 2023C
# Assessment: Assignment 3
# Author: Group 3
# Created  date: 02/01/2023
# Last modified: 20/01/2023
# Acknowledgement: None

# Install Python 3.11 (replace x with the actual version number)
sudo yum install -y python3.7

# Install pip3
sudo yum install -y python3-pip

# Create and activate a virtual environment
python3.7 -m venv myenv
source myenv/bin/activate

# Install Selenium
pip3 install selenium

# Check Selenium version
pip3 show selenium

# Install essential packages
sudo yum install -y wget unzip xorg-x11-server-Xvfb firefox java-11-openjdk-devel

# Install Firefox
sudo amazon-linux-extras install -y epel
sudo amazon-linux-extras install firefox

# Check Firefox version
firefox --version

# Install geckodriver - version 0.34.0
# wget https://github.com/mozilla/geckodriver/releases/download/v0.34.0/geckodriver-v0.34.0-linux64.tar.gz
# tar -xvzf geckodriver-v0.34.0-linux64.tar.gz
# sudo mv geckodriver /usr/local/bin/

# Add geckodriver to the system PATH
export PATH=$PATH:/usr/local/bin/

# Start Xvfb
Xvfb :99 -screen 0 1024x768x24 &
export DISPLAY=:99

# Done. Run Selenium test now.
